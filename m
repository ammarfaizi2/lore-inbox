Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbUCJPTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbUCJPTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:19:54 -0500
Received: from [217.157.19.70] ([217.157.19.70]:13321 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S262653AbUCJPTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:19:52 -0500
Date: Wed, 10 Mar 2004 15:19:50 +0000 (GMT)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: andre@linux-ide.org, <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.x Linux Medley RAID Version 7
In-Reply-To: <200403101539.28258.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.40.0403101515410.1120-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Bartlomiej Zolnierkiewicz wrote:

> I don't like the idea of having 2 drivers doing basically the same thing.
> Please explain why we can't have one Medley software RAID driver?
> [ Yes, I read http://www.ussg.iu.edu/hypermail/linux/kernel/0308.0/0156.html ]

The existing one does not work correctly:

- It detects the array in the wrong way and so only catches a fraction of
valid Medley sets (and possibly mistakes non-Medley sets or deleted sets
for correct ones).

- It's using the wrong algorithm for dealing with striped arrays where the
drives are of different sizes.

The reason my patch leaves it in place is that it works for some users,
and some people pointed out last year that the usual preferred path for
this kind of change is to leave the existing driver in place if it works
for some people. I would personally prefer to remove it.

Andre has previously stated that he had no objections to this patch (an
earlier version).

// Thomas


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbULVE7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbULVE7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 23:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbULVE7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 23:59:05 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:61078 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261254AbULVE7D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 23:59:03 -0500
From: David Brownell <david-b@pacbell.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] USB: fix Scheduling while atomic warning when resuming.
Date: Tue, 21 Dec 2004 20:59:15 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
References: <200412220103.iBM13wS0002158@hera.kernel.org> <200412212022.52316.david-b@pacbell.net> <41C8FC25.2060304@pobox.com>
In-Reply-To: <41C8FC25.2060304@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412212059.15426.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 December 2004 8:46 pm, Jeff Garzik wrote:
> > If that lock were dropped, what would prevent other tasks from
> > touching the hardware while it's sending RESUME signaling down
> > the bus, and thereby mucking up the resume sequence?
> 
> Precisely what other tasks are active for this hardware, during resume?

There's no guarantee that suspend() and resume() methods
are only called during system-wide suspend and resume.

And likewise, if there were no other tasks, why should
you even be concerned about spinning vs sleeping?

- Dave

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265484AbUFVUch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265484AbUFVUch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUFVU2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:28:30 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:65017 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265902AbUFVU01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:26:27 -0400
Date: Tue, 22 Jun 2004 16:17:25 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: <kernel@mikebell.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: SATA 3112 errors on 2.6.7
In-Reply-To: <20040620023833.GN497@tinyvaio.nome.ca>
Message-ID: <Pine.GSO.4.33.0406221614050.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004 kernel@mikebell.org wrote:
>To confirm, I also see the problem despite adding the drives to
>the blacklist on 2.6.7.

Yeah.  I uncovered a small oops in there.  libsata-scsi.c resets max_sectors
if LBA48 is enabled.  Mr. Garzik has been sent a patch (maybe not "the"
patch.)  I'm still digging into this one as I don't like losing 50% of
my drives speed.  SI eats more than enough on it's own.

--Ricky



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUEJXlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUEJXlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUEJXjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:39:55 -0400
Received: from cathy.bmts.com ([216.183.128.202]:19413 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S261791AbUEJXhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:37:45 -0400
Date: Mon, 10 May 2004 19:36:59 -0400
From: Mike Houston <mikeserv@bmts.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-Id: <20040510193659.77e474a7.mikeserv@bmts.com>
In-Reply-To: <409FFB44.5030304@keyaccess.nl>
References: <409F4944.4090501@keyaccess.nl>
	<200405102125.51947.bzolnier@elka.pw.edu.pl>
	<409FF068.30902@keyaccess.nl>
	<409FFB44.5030304@keyaccess.nl>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-bmts-MailScanner: Found to be clean
X-bmts-MailScanner-SpamCheck: 
X-MailScanner-From: mikeserv@bmts.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004 23:59:32 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> Rene Herman wrote:
> 
> > With this one, the cache flushing noise is no more, but still a problem 
> > unfortunately. With or without these patches, 2.6.6 powers down the 
> > drive during reboot. This is very annoying, seeing as how it immediately 
> > needs to spin up again for POST.
> 
> Sorry, mistaken. This only happens _with_ your change. Without, 2.6.6 
> just complains.
> 
> Rene.

I am having this "spin up" behaviour with plain 2.6.6 (I haven't tried any patches)

On reboot, after it suspended the drives, there is a roughly 15 second delay at post while the bios is initializing the hard disks. During this time the hard disk LED is lit.

Shut down and power up behaviour is normal, it's only on a reboot that the above occurs.

Hardware: Pentium4, Gigabyte motherboard, i845, ICH2 IDE controllers.
Disks:  Two identical Maxtor 40 Gb 6E040L0 models. Primary master and primary slave. UDMA (100).

Note that I do hear a bit of a "cache flush" noise, but I assume that's normal because Windows XP makes that same noise when shutting down. It seems to be a normal hard disk sound.

I do not get any complaints like you have in the boot logs though. Everything is normal unless I reboot (and even that is just a trivial delay and probably not at all harmful)

Mike


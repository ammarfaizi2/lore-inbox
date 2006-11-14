Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755348AbWKNEvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbWKNEvD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 23:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbWKNEvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 23:51:03 -0500
Received: from mail.ggsys.net ([69.26.161.131]:21399 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S1755348AbWKNEvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 23:51:01 -0500
Subject: Re: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45588132.9090200@rtr.ca>
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>
	 <1163180185.28843.13.camel@w100>  <4556AC74.3010000@rtr.ca>
	 <1163363479.3423.8.camel@w100>  <45588132.9090200@rtr.ca>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Mon, 13 Nov 2006 22:50:51 -0600
Message-Id: <1163479852.3340.9.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Things are improving, after the latest patch I can still
see spurious messages, but the count stays at 0.

Sorry for including all the lines, but I think it may help
to see if a time pattern is visible. Here is the output:

Nov 13 14:01:08 w100 kernel: scsi0 : sata_qstor
Nov 13 14:01:08 w100 kernel: scsi1 : sata_qstor
Nov 13 14:01:08 w100 kernel: scsi2 : sata_qstor
Nov 13 14:01:08 w100 kernel: scsi3 : sata_qstor
Nov 13 14:05:15 w100 kernel: sata_qstor: spurious=0
Nov 13 14:08:29 w100 kernel: sata_qstor: spurious=0
Nov 13 14:11:01 w100 kernel: sata_qstor: spurious=0
Nov 13 14:11:06 w100 kernel: sata_qstor: spurious=0
Nov 13 14:15:03 w100 kernel: sata_qstor: spurious=0
Nov 13 14:20:28 w100 kernel: sata_qstor: spurious=0
Nov 13 14:28:44 w100 kernel: sata_qstor: spurious=0
Nov 13 14:40:40 w100 kernel: sata_qstor: spurious=0
Nov 13 14:46:53 w100 kernel: sata_qstor: spurious=0
Nov 13 15:00:15 w100 kernel: sata_qstor: spurious=0
Nov 13 15:01:52 w100 kernel: sata_qstor: spurious=0
Nov 13 15:13:18 w100 kernel: sata_qstor: spurious=0
Nov 13 15:18:25 w100 kernel: sata_qstor: spurious=0
Nov 13 15:19:57 w100 kernel: sata_qstor: spurious=0
Nov 13 15:24:56 w100 kernel: sata_qstor: spurious=0
Nov 13 15:32:52 w100 kernel: sata_qstor: spurious=0
Nov 13 15:32:53 w100 kernel: sata_qstor: spurious=0
Nov 13 15:37:47 w100 kernel: sata_qstor: spurious=0
Nov 13 15:42:30 w100 kernel: sata_qstor: spurious=0
Nov 13 15:42:33 w100 kernel: sata_qstor: spurious=0
Nov 13 15:45:50 w100 kernel: sata_qstor: spurious=0
Nov 13 15:54:53 w100 kernel: sata_qstor: spurious=0
Nov 13 15:59:32 w100 kernel: sata_qstor: spurious=0
Nov 13 16:04:07 w100 kernel: sata_qstor: spurious=0
Nov 13 16:06:01 w100 kernel: sata_qstor: spurious=0
Nov 13 16:07:24 w100 kernel: sata_qstor: spurious=0
Nov 13 16:19:54 w100 kernel: sata_qstor: spurious=0
Nov 13 16:19:55 w100 kernel: sata_qstor: spurious=0
Nov 13 16:27:34 w100 kernel: sata_qstor: spurious=0
Nov 13 16:33:21 w100 kernel: sata_qstor: spurious=0
Nov 13 16:39:57 w100 kernel: sata_qstor: spurious=0
Nov 13 16:42:38 w100 kernel: sata_qstor: spurious=0
Nov 13 16:43:40 w100 kernel: sata_qstor: spurious=0
Nov 13 16:50:36 w100 kernel: sata_qstor: spurious=0
Nov 13 16:52:11 w100 kernel: sata_qstor: spurious=0
Nov 13 16:53:41 w100 kernel: sata_qstor: spurious=0
Nov 13 16:58:30 w100 kernel: sata_qstor: spurious=0
Nov 13 17:18:40 w100 kernel: sata_qstor: spurious=0
Nov 13 17:20:21 w100 kernel: sata_qstor: spurious=0
Nov 13 17:20:46 w100 kernel: sata_qstor: spurious=0
Nov 13 17:24:02 w100 kernel: sata_qstor: spurious=0
Nov 13 17:27:26 w100 kernel: sata_qstor: spurious=0
Nov 13 17:35:40 w100 kernel: sata_qstor: spurious=0
Nov 13 17:39:01 w100 kernel: sata_qstor: spurious=0
Nov 13 17:40:23 w100 kernel: sata_qstor: spurious=0
Nov 13 18:03:57 w100 kernel: sata_qstor: spurious=0
Nov 13 18:08:16 w100 kernel: sata_qstor: spurious=0
Nov 13 18:11:20 w100 kernel: sata_qstor: spurious=0
Nov 13 18:16:32 w100 kernel: sata_qstor: spurious=0
Nov 13 18:16:32 w100 kernel: sata_qstor: spurious=0
Nov 13 18:21:28 w100 kernel: sata_qstor: spurious=0
Nov 13 18:22:57 w100 kernel: sata_qstor: spurious=0
Nov 13 18:26:36 w100 kernel: sata_qstor: spurious=0
Nov 13 18:29:21 w100 kernel: sata_qstor: spurious=0
Nov 13 18:32:34 w100 kernel: sata_qstor: spurious=0
Nov 13 18:34:39 w100 kernel: sata_qstor: spurious=0
Nov 13 18:36:17 w100 kernel: sata_qstor: spurious=0
Nov 13 18:38:07 w100 kernel: sata_qstor: spurious=0
Nov 13 18:42:58 w100 kernel: sata_qstor: spurious=0
Nov 13 18:45:19 w100 kernel: sata_qstor: spurious=0
Nov 13 18:47:14 w100 kernel: sata_qstor: spurious=0
Nov 13 18:49:42 w100 kernel: sata_qstor: spurious=0
Nov 13 18:52:22 w100 kernel: sata_qstor: spurious=0
Nov 13 18:55:28 w100 kernel: sata_qstor: spurious=0
Nov 13 18:55:42 w100 kernel: sata_qstor: spurious=0
Nov 13 19:00:12 w100 kernel: sata_qstor: spurious=0
Nov 13 19:04:15 w100 kernel: sata_qstor: spurious=0
Nov 13 19:10:41 w100 kernel: sata_qstor: spurious=0
Nov 13 19:12:11 w100 kernel: sata_qstor: spurious=0
Nov 13 19:15:51 w100 kernel: sata_qstor: spurious=0
Nov 13 19:20:12 w100 kernel: sata_qstor: spurious=0
Nov 13 19:24:27 w100 kernel: sata_qstor: spurious=0
Nov 13 19:26:40 w100 kernel: sata_qstor: spurious=0
Nov 13 19:30:41 w100 kernel: sata_qstor: spurious=0
Nov 13 19:38:02 w100 kernel: sata_qstor: spurious=0
Nov 13 19:41:07 w100 kernel: sata_qstor: spurious=0
Nov 13 19:42:42 w100 kernel: sata_qstor: spurious=0
Nov 13 19:48:06 w100 kernel: sata_qstor: spurious=0
Nov 13 19:55:05 w100 kernel: sata_qstor: spurious=0
Nov 13 19:55:07 w100 kernel: sata_qstor: spurious=0
Nov 13 19:58:00 w100 kernel: sata_qstor: spurious=0
Nov 13 19:58:07 w100 kernel: sata_qstor: spurious=0
Nov 13 20:05:51 w100 kernel: sata_qstor: spurious=0
Nov 13 20:08:32 w100 kernel: sata_qstor: spurious=0
Nov 13 20:09:39 w100 kernel: sata_qstor: spurious=0
Nov 13 20:11:54 w100 kernel: sata_qstor: spurious=0
Nov 13 20:17:19 w100 kernel: sata_qstor: spurious=0
Nov 13 20:17:57 w100 kernel: sata_qstor: spurious=0
Nov 13 20:23:48 w100 kernel: sata_qstor: spurious=0
Nov 13 20:25:14 w100 kernel: sata_qstor: spurious=0
Nov 13 20:25:16 w100 kernel: sata_qstor: spurious=0
Nov 13 20:28:56 w100 kernel: sata_qstor: spurious=0
Nov 13 20:29:00 w100 kernel: sata_qstor: spurious=0
Nov 13 20:32:39 w100 kernel: sata_qstor: spurious=0
Nov 13 20:35:06 w100 kernel: sata_qstor: spurious=0
Nov 13 20:38:20 w100 kernel: sata_qstor: spurious=0
Nov 13 20:41:30 w100 kernel: sata_qstor: spurious=0
Nov 13 20:41:33 w100 kernel: sata_qstor: spurious=0
Nov 13 20:45:00 w100 kernel: sata_qstor: spurious=0
Nov 13 21:08:22 w100 kernel: sata_qstor: spurious=0
Nov 13 21:10:28 w100 kernel: sata_qstor: spurious=0
Nov 13 21:13:26 w100 kernel: sata_qstor: spurious=0
Nov 13 21:15:22 w100 kernel: sata_qstor: spurious=0
Nov 13 21:23:32 w100 kernel: sata_qstor: spurious=0
Nov 13 21:24:11 w100 kernel: sata_qstor: spurious=0
Nov 13 21:26:40 w100 kernel: sata_qstor: spurious=0
Nov 13 21:33:14 w100 kernel: sata_qstor: spurious=0
Nov 13 21:45:55 w100 kernel: sata_qstor: spurious=0
Nov 13 21:45:57 w100 kernel: sata_qstor: spurious=0
Nov 13 21:56:52 w100 kernel: sata_qstor: spurious=0
Nov 13 21:56:56 w100 kernel: sata_qstor: spurious=0
Nov 13 22:01:53 w100 kernel: sata_qstor: spurious=0
Nov 13 22:22:46 w100 kernel: sata_qstor: spurious=0
Nov 13 22:30:44 w100 kernel: sata_qstor: spurious=0
Nov 13 22:38:52 w100 kernel: sata_qstor: spurious=0
Nov 13 22:41:48 w100 kernel: sata_qstor: spurious=0
Nov 13 22:43:20 w100 kernel: sata_qstor: spurious=0
Nov 13 22:44:58 w100 kernel: sata_qstor: spurious=0


Thanks,

Alberto

On Mon, 2006-11-13 at 09:29 -0500, Mark Lord wrote:
> Alberto Alonso wrote:
> > OK, after adding the printk line I can start seeing
> > results.
> > 
> > I guess it has been close to 10 on quite a few
> > occasions.
> ..
> > # grep qstor /var/log/messages
> > Nov 12 07:00:53 w100 kernel: sata_qstor: spurious=0
> > Nov 12 07:00:53 w100 kernel: sata_qstor: spurious=1
> > Nov 12 07:00:53 w100 kernel: sata_qstor: spurious=0
> > Nov 12 07:00:56 w100 kernel: sata_qstor: spurious=1
> > Nov 12 07:00:56 w100 kernel: sata_qstor: spurious=2
> ..
> > On Sun, 2006-11-12 at 00:09 -0500, Mark Lord wrote:
> >> Alberto Alonso wrote:
> >>> The saga continues. It happened again this morning even with the
> >>> patch:
> >> ..
> >>>> Mmm.. We could apply a bit of fuzzy tolerance for the odd glitch.
> >>>> Try this patch (attached) and report back.
> >> Did you add the printk() to the patch, as suggested?
> ..
> 
> Excellent!
> 
> So, either we have a very noisy bit of hardware in there,
> or something is wrong with sata_qstor.c.
> 
> The device has two methods for dealing with commands.
> Regular R/W uses the driver's host queue "packet" interface,
> and all other commands pass through the legacy MMIO mechanism.
> 
> I'm betting on some bug/interaction with the latter.
> 
> Try this patch and see what happens, on top of the printk patch.
> 
> Thanks
> 
> 
> 
-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups


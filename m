Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVCYAwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVCYAwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 19:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVCYAwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:52:05 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:62160 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261333AbVCYAj5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:39:57 -0500
Date: Fri, 25 Mar 2005 01:45:03 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       video4linux-list@redhat.com
Subject: Re: [PATCH 2.6.11.2][2/2] printk with anti-cluttering-feature
In-Reply-To: <Pine.LNX.4.58.0503210922080.2810@be1.lrz>
Message-ID: <Pine.LNX.4.58.0503250139110.4442@be1.lrz>
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz> <423D6353.5010603@tls.msk.ru>
 <Pine.LNX.4.58.0503201425080.2886@be1.lrz> <Pine.LNX.4.58.0503202151360.2869@be1.lrz>
 <Pine.LNX.4.58.0503202235380.3051@be1.lrz> <Pine.LNX.4.58.0503210922080.2810@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Bodo Eggert wrote:
> On Sun, 20 Mar 2005, Bodo Eggert wrote:

I just sent an alternative fix kot atkbd.c, which clashes with the 
previous version of this patch. This leaves un with one place where 
printk_nospam is used. Just in case you still think it's usefull, here is 
the modified patch.

BTW: If you're bugged by other kernel messages, I can add them, too.

> The new kernels have tuner.c fixed differently, removed that part.
> 
> > Update some functions to use printk_nospam

> > Signed-Off-By: Bodo Eggert <7eggert@gmx.de>
> > 
> > diff -purNXdontdiff linux-2.6.11/drivers/block/scsi_ioctl.c linux-2.6.11.new/drivers/block/scsi_ioctl.c
> > --- linux-2.6.11/drivers/block/scsi_ioctl.c	2005-03-03 15:41:28.000000000 +0100
> > +++ linux-2.6.11.new/drivers/block/scsi_ioctl.c	2005-03-20 14:56:55.000000000 +0100
> > @@ -547,7 +547,7 @@ int scsi_cmd_ioctl(struct file *file, st
> >  		 * old junk scsi send command ioctl
> >  		 */
> >  		case SCSI_IOCTL_SEND_COMMAND:
> > -			printk(KERN_WARNING "program %s is using a deprecated SCSI ioctl, please convert it to SG_IO\n", current->comm);
> > +			printk_nospam(2296159591, KERN_WARNING "program %s is using a deprecated SCSI ioctl, please convert it to SG_IO\n", current->comm);
> >  			err = -EINVAL;
> >  			if (!arg)
> >  				break;
-- 
Funny quotes:
38. Last night I played a blank tape at full blast. The mime next door went
    nuts.
Friﬂ, Spammer: h9ygOoywhhiagv@subvalue.com customerservice@weretoblamefor.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWFVMG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWFVMG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 08:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbWFVMG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 08:06:59 -0400
Received: from mail.fh-wolfenbuettel.de ([141.41.8.160]:23189 "EHLO
	mail.fh-wolfenbuettel.de") by vger.kernel.org with ESMTP
	id S1030249AbWFVMG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 08:06:58 -0400
Date: Thu, 22 Jun 2006 14:06:56 +0200
From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
Subject: WG: [-mm patch] make drivers/usb/misc/cy7c63.c:vendor_command() static
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net
Message-id: <174794175ce6.175ce6174794@fh-wolfenbuettel.de>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 2.04 (built Feb  8 2005)
Content-type: text/plain; charset=us-ascii
Content-language: de
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right. I'll fix that and resend the current version[1] as a reply
to your message below...

Thanks, Oliver


[1] http://lkml.org/lkml/2006/6/18/128



----- Originalnachricht -----
Von: Adrian Bunk <bunk@stusta.de>
Datum: Donnerstag, Juni 22, 2006 1:37 am
Betreff: [-mm patch] make drivers/usb/misc/cy7c63.c:vendor_command() static

> On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-rc6-mm2:
> >...
> > +gregkh-usb-usb-new-driver-for-cypress-cy7c63xxx-mirco-
> controllers.patch>...
> >  USB tree updates
> >...
> 
> This patch makes the needlessly global vendor_command() static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.17-mm1-full/drivers/usb/misc/cy7c63.c.old	2006-06-22 
> 01:25:08.000000000 +0200
> +++ linux-2.6.17-mm1-full/drivers/usb/misc/cy7c63.c	2006-06-22 
> 01:25:57.000000000 +0200
> @@ -63,8 +63,8 @@
> };
> 
> /* used to send usb control messages to device */
> -int vendor_command(struct cy7c63 *dev, unsigned char request,
> -                         unsigned char address, unsigned char 
> data) {
> +static int vendor_command(struct cy7c63 *dev, unsigned char request,
> +                          unsigned char address, unsigned char 
> data) {
> 
> 	int retval = 0;
> 	unsigned int pipe;
> 
> 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVGVJhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVGVJhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVGVJhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:37:20 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:42959 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261537AbVGVJgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:36:47 -0400
Date: Fri, 22 Jul 2005 11:37:58 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: randy_dunlap <rdunlap@xenotime.net>
cc: Bodo Eggert <7eggert@gmx.de>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND] [1b/5+1] menu -> menuconfig part 1
In-Reply-To: <20050721220711.092e176e.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.58.0507221059020.2255@be1.lrz>
References: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
 <Pine.LNX.4.58.0507171326470.6041@be1.lrz> <Pine.LNX.4.58.0507171902030.16515@be1.lrz>
 <20050721220711.092e176e.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2005, randy_dunlap wrote:
> On Sun, 17 Jul 2005 19:03:09 +0200 (CEST) Bodo Eggert wrote:
> > On Sun, 17 Jul 2005, Bodo Eggert wrote:
> > > On Sun, 17 Jul 2005, Bodo Eggert wrote:
> > 
> > > > These patches change some menus into menuconfig options.
> > > > 
> > > > Reworked to apply to linux-2.6.13-rc3-git3
> > > 
> > > Mostly robotic works.
> > 
> > Fixup: unbreak i2c menu
> 
> Hi Bodo,
> 
> Was there supposed to be a patch here?
> I do see that the I2C menu is broken...

There should be an incremental fix for _my_ patch, where I missed one 
"depend" and thereby caused the menu to break apart.

Sorry if I wasn't clear enough.

Here it is:


 drivers/i2c/chips/Kconfig |    1 +
 1 files changed, 1 insertion(+)

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

--- a/drivers/i2c/chips/Kconfig~	2005-07-17 18:54:16.000000000 +0200
+++ b/drivers/i2c/chips/Kconfig	2005-07-17 18:54:16.000000000 +0200
@@ -4,6 +4,7 @@
 
 config I2C_SENSOR
 	tristate
+	depends on I2C
 	default n
 
 menu "Miscellaneous I2C Chip support"
-- 
Everything always works in your HQ, everything always fails in the colonel's
HQ.

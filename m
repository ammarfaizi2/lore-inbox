Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVECXSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVECXSq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 19:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVECXSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 19:18:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:63432 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261904AbVECXQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 19:16:19 -0400
Date: Tue, 3 May 2005 16:16:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
Message-Id: <20050503161602.511a7dfc.rddunlap@osdl.org>
In-Reply-To: <20050503230532.GA13063@animx.eu.org>
References: <20050503012951.GA10459@animx.eu.org>
	<20050502193503.20e6ac6e.rddunlap@osdl.org>
	<20050503104503.GA11123@animx.eu.org>
	<20050503072626.3a3c7349.rddunlap@osdl.org>
	<20050503163343.GC11937@animx.eu.org>
	<20050503095913.1c9b62ba.rddunlap@osdl.org>
	<20050503221922.GC12199@animx.eu.org>
	<20050503153737.5e3627ad.rddunlap@osdl.org>
	<20050503230532.GA13063@animx.eu.org>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2005 19:05:32 -0400 Wakko Warner wrote:

| Randy.Dunlap wrote:
| > On Tue, 3 May 2005 18:19:22 -0400 Wakko Warner wrote:
| > 
| > | Randy.Dunlap wrote:
| > | > On Tue, 3 May 2005 12:33:43 -0400 Wakko Warner wrote:
| > | > | Yes, I do recall it says "System is 724k".  zImage failes.  bzImage says
| > | > | 724k as well and succeeds.
| > | > 
| > | > The image size needs to be <= 0x7f000 (520192 bytes, 508 KB).
| > | > 
| > | > (No, I don't know why, just that this is what is being
| > | > enforced.)
| > | > 
| > | > Just cut more out of the kernel image...
| > | 
| > | Any suggestions?  All that I know of that is modularizable is a module,
| > | except for keyboard, ext2, unix sockets, ramdisk+initrd.  Some of the options I need since
| > | this is supposed to support all relevent hardware that we use where I work.
| > | (all scsi,ide,sata,raid cards,ethernet cards that we have)
| > 
| > Are those (mostly) modular?
| 
| Yes.
| 
| > Is this supposed to be a kernel that is used on a regular basis,
| > not just a temporary quick boot thing?
| 
| I'd say it would be used frequently, but short lived.
| 
| > You want one kernel that handles many configurations but fits
| > in < 510 KB?  That is aggressive.  :)
| 
| =)  hehe, if I can.
| 
| > I think of this as being a custom kernel, but it sounds
| > like you want a very general-purpose (small) one.
| 
| Yes, very custom.
| 
| 
| > | SCSI_PROC_FS=y
| > drop this one
| > 
| > | AIC7XXX_DEBUG_ENABLE=y
| > | AIC7XXX_REG_PRETTY_PRINT=y
| > | AIC79XX_DEBUG_ENABLE=y
| > | AIC79XX_REG_PRETTY_PRINT=y
| > drop these.
| 
| All SCSI is a module, these I assume are just capabilites in the modules.

OK.

| > | SOUND_GAMEPORT=y
| > drop.
| 
| Couldn't find a configure option to disable this.  It caught my eye too.  I
| don't have gameport in input configured.

OK, probably hidden.

| > | VT=y
| > | VT_CONSOLE=y
| > | HW_CONSOLE=y
| > | VGA_CONSOLE=y
| > | DUMMY_CONSOLE=y
| > drop that ^^^^^
| 
| All of those or DUMMY_CONSOLE?

I meant just DUMMY_CONSOLE.

| 
| > so what's the problem with using a bzImage kernel?
| 
| Nothing, I wanted to see if zImage would be smaller.  As others have stated,
| it's not.  However, I did not know this.
| 
| I do appriate your time in helping me.  I'm real close to getting this on a
| single floppy (if I formatted to 1.7mb, it would be easy.  I know some of
| our systems that I would need this on can't use these).  One goal is to use
| the same kernel for all booting.

Good luck, have fun.

---
~Randy

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285013AbRLQFs4>; Mon, 17 Dec 2001 00:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285014AbRLQFsq>; Mon, 17 Dec 2001 00:48:46 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:40466 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S285013AbRLQFsh>; Mon, 17 Dec 2001 00:48:37 -0500
Date: Mon, 17 Dec 2001 06:48:25 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc1 does not boot my Alphas
Message-ID: <20011217054825.GA12057@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20011216160404.A2945@mail.harddata.com> <3C1D4871.82053E7A@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1D4871.82053E7A@zk3.dec.com>
User-Agent: Mutt/1.3.24i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 08:20:49PM -0500, Peter Rival wrote:
> Michal Jaegermann wrote:
> 
> > I just happen to have an access right now to two Alpha machines,
> > UP1100 and UP1500, both with Nautilus chipset.  Neither of these
> > can be booted with 2.4.16 or 2.4.17rc1. On an attempt to boot
> > I can see only messages from a boot loader (aboot):
> > .....
> > zero-filling 155872 bytes at 0xffffc0000ad1308
> > starting kernel vmlinux.......
> >
> > and that is it.  The only thing which works now is a power switch.
> Try again, this time adding "srmcons" to the boot flags.  You're croaking
> before we get the console set up under Linux so none of the boot messages are
> getting out; srmcons uses the SRM console to print its messages.  This won't
> fix the bugs, but at least we'll be able to see exactly where you die.
> 
Perhaps the wording of CONFIG_ALPHA_SRM in Configure.help could be a bit
stronger;

Use SRM as bootloader
CONFIG_ALPHA_SRM
  There are two different types of booting firmware on Alphas: SRM,
  which is command line driven, and ARC, which uses menus and arrow
  keys. Details about the Linux/Alpha booting process are contained in
  the Linux/Alpha FAQ, accessible on the WWW from
  <http://www.alphalinux.org/>.

  The usual way to load Linux on an Alpha machine is to use MILO
  (a bootloader that lets you pass command line parameters to the
  kernel just like lilo does for the x86 architecture) which can be
  loaded either from ARC or can be installed directly as a permanent
  firmware replacement from floppy (which requires changing a certain
  jumper on the motherboard). If you want to do either of these, say N
  here. If MILO doesn't work on your system (true for Jensen
  motherboards), you can bypass it altogether and boot Linux directly
  from an SRM console; say Y here in order to do that. Note that you
  won't be able to boot from an IDE disk using SRM.

  If unsure, say N.

Perhaps something like: 

If unsure, say N if you boot linux via MILO, or Y if you boot linux via
SRM.

I was fooled by this one also, and with the current text, I read it like
'saying N is safe'.

Jurriaan
-- 
`That right?' Hawk gave MacReady a long, thoughtful look.
`I'll have to remember that.'
	Simon R Green - Hawk & Fisher II Fear and Loathing in Haven
GNU/Linux 2.4.17-rc1 on Debian/Alpha 64-bits 990 bogomips load:1.63 1.20 1.06

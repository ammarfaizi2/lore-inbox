Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSEETEF>; Sun, 5 May 2002 15:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313304AbSEETEE>; Sun, 5 May 2002 15:04:04 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:352 "EHLO mole.bio.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S313293AbSEETED> convert rfc822-to-8bit;
	Sun, 5 May 2002 15:04:03 -0400
Message-Id: <5.1.0.14.2.20020505200138.00b2d660@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 05 May 2002 20:04:04 +0100
To: william stinson <wstinsonfr@yahoo.fr>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: vanilla 2.5.13 severe file system corruption experienced
  follozing e2fsck ...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020505183451.98763.qmail@web14102.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IDE core has a nasty PIO bug which causes it to scribble randomly over 
your disk (even when read-only mounted or not mounted at all).

Wait for 2.5.14, that has the fix in it, or use the latest -dj kernel which 
has the fix, too.

Note even with that fix IDE (at least TCQ) is really easy to crash when you 
put the system under heavier I/O (at least on my via box)...

Anton

At 19:34 05/05/02, william stinson wrote:
>Hi
>
>as vanilla linux 2.5.13 compiled beautifully for me
>last night one I couldn't resist the temptation to
>boot it up and give it a whirl on my workstation (a
>monoprocessor AMD  ATHLON on VIA motherboard with
>recent 20GB IDE disk and EXT2 file system, NVIDIA
>video card).
>
>Boot went OK until a message something like "checking
>filesystems - check forced -mounted  31 times without
>verification - verifying now". Shortly afterwards I
>got an OOPS message.
>
>
>EIP : 0010: [<c01d59cb> Not Tainted
>....
><0> Kernel Panic: Aiee, killing interrupt handler! In
>interrupt handler - not syncing
>
>Not to worry I try to reboot my stable kernel - this
>fails at the mount command (library's needed by mount
>command are missing). Impossible to login (password
>file must be corrupted too).
>
>With the rescue disk I run e2fsck and home partition
>is  dead (bad superblocks) and nothing recoverable.
>The root file system is also corrupted (bad
>superblocks but not as badly as home). I have some
>other partitions which I haven't checked yet - maybe
>some of them survived.
>
>As I am not subscribed to the list please CC me in any
>response. If I can recover the kernel compile I will
>try to give some configuration options and try to
>decode the full oops message. More details available
>on request.
>
>Best regards
>William Stinson (wstinsonfr@yahoo.fr.nospam)
>
>P.S.
>
>  The hard disk is using VIA bus master PCI IDE and the
>distribution is a "vanilla" mandrake 8.1. I have a
>REALTEK  RTL8029 Ethernet Adaptor. USB is with VIA
>VT83C572/VT82C586 PCI to VIA Universal Host
>controller.
>
>___________________________________________________________
>Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
>Yahoo! Mail : http://fr.mail.yahoo.com
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285273AbSAZQIJ>; Sat, 26 Jan 2002 11:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285338AbSAZQIA>; Sat, 26 Jan 2002 11:08:00 -0500
Received: from mail.skjellin.net ([193.69.71.67]:55438 "HELO mail.skjellin.net")
	by vger.kernel.org with SMTP id <S285273AbSAZQHp> convert rfc822-to-8bit;
	Sat, 26 Jan 2002 11:07:45 -0500
Subject: Re: acpi-rouble/amd disconnect patch
From: Andre Tomt <andre@tomt.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020126122115.71FBA141B@shrek.lisa.de>
In-Reply-To: <Pine.LNX.4.40.0201251248090.30265-100000@hades.uni-trier.de>
	<1011968738.22709.29.camel@psuedomode>
	<20020125203210Z290512-13996+12129@vger.kernel.org> 
	<20020126122115.71FBA141B@shrek.lisa.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1 
Date: 26 Jan 2002 17:07:41 +0100
Message-Id: <1012061261.6245.15.camel@slurv.home.i.vpn.tomt.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-26 at 13:21, Hans-Peter Jansen wrote:
> Let's try to sort out things chipset wise:
> 
> asus a7v133 (KT133, 100 FSB, 12*): system flaky

asus a7v133 (KT133A, 133(266)FSB, *10.5, 1.4Ghz Thunderbird, 768MB RAM).
Stable, no obvious problems or performance issues. CPU temperature at
32C during xmms, ssh usage.

mp3 playback is rock solid, even during heavy system load (two plus
compiles, mozilla etc), and also with no system load. mpeg-video
playback is smooth as always (mplayer with /dev/mga_vid), both with
heavy load and without heavy load.

kernel is 2.4.18-pre7 with preempt and lockbreak, plust a readlatency
patch.

However, I prefer amd_disconnect disabled, for obvious reasons pointed
out by other people on this list.. Temperature is now at an acceptable
42C after a while of normal load, using just acpi in kernel.

# lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev
03)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
40)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06)
00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 07)
00:09.1 Input device controller: Creative Labs SB Live! (rev 07)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt848 TV with
DMA push (rev 12)
00:0c.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c1010 Ultra3 SCSI Adapter (rev 01)
00:0c.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c1010 Ultra3 SCSI Adapter (rev 01)
00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 34)
00:11.0 Unknown mass storage controller: Promise Technology, Inc.:
Unknown device 0d30 (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 04)

just my 2 kr.
 
-- 
Mvh,
André Tomt
andre@tomt.net


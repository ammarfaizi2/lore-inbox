Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286721AbRL1C5n>; Thu, 27 Dec 2001 21:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286695AbRL1C5d>; Thu, 27 Dec 2001 21:57:33 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:7056 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S286699AbRL1C5O>; Thu, 27 Dec 2001 21:57:14 -0500
Subject: VIA based motherboards
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 27 Dec 2001 21:57:16 -0500
Message-Id: <1009508239.1440.0.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I had read several reviews of the Soyo Dragon Plus saying it was
great and stable with Linux (kt266a based board).

I have a Micron 256 Meg DDR DIMM in my system.  With my Permedia 2 video
card and my hard drives (and every built in thing turned off and all
other components not mentioned removed) the system crashes at boot if I
let Linux use all 256 Meg.  If I say mem=240M it works fine (as far as I
have seen).  If I say anything over 240M, either it hangs when trying to
print out the partition table check on boot, or it hangs in the SCSI
card driver for my Symbios 876 based card (if it is in... maybe if it is
out, didn't check).

I do not know if the BIOS edits 55 register in the Northbridge or the
91.  2.4.18pre1 doesn't seem to apply the fix, so it must already be
done.

Again, even without that Symbios based SCSI card, the system hangs
unless I say mem=240M.  However, I ran memcheck 98 (I believe that was
the name) v2.8.  It ran many passes (all tests enabled, with or without
cache).  After 2 days of it running with all tests, cache controlled by
test, around 9 passes I believe, the tests passed with no problems.  My
system hung around 8 hours later with all keyboard LED lights on, it
rebooted and started running the test again.  The keyboard stayed hung
until power was physically removed from the computer AND keyboard was
unplugged and plugged back in.

I have tried telling the BIOS to do normal (not fast/keyboard
controlled) GATE A20.  This didn't change the keyboard hanging or the
hang problem described here.

Is my memory bad?  Is the workaround being screwed up by the BIOS?  Is
there something wrong with Linux?

Currently my BIOS says that the drive is different than what the
partition table says.  The bios apparently doesn't tell the OS what it
sees it as (because I set it in the BIOS to do LBA, which is what the
partition is, and the numbers do match according to it).  If the drive
is primary (it isn't) on the chain, Linux, BIOS, and partition table all
see it the same and the crash happens the same or a little later, but
crashes all the same.  Later is right before or right after INIT would
be started.

I had the same problems with an EPOX 8KHA+ board (same chipset).  I
thought it was bad and so got this board.

Any help would be appreciated.

Trever Adams

P.S. I would have gotten AMD but many people warned against it because
they are soon to stop making 760 chipsets.

P.P.S. Alan Cox, if you read this, I haven't forgotten your request for
DMI scan info from that Venturis (similar to Celebris).  I just haven't
had a working computer for over 2 weeks to send the request with.





Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRBGPRW>; Wed, 7 Feb 2001 10:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbRBGPRM>; Wed, 7 Feb 2001 10:17:12 -0500
Received: from gatekeeper.gozer.weebeastie.net ([61.8.7.91]:37637 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S129245AbRBGPRE>; Wed, 7 Feb 2001 10:17:04 -0500
Date: Thu, 8 Feb 2001 02:14:47 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: suspecious ide hdparm results with 2.4.1 (and a minor capacity question)
Message-ID: <20010208021447.C352@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well I got my ATA100 IBM HD and my Promise ATA100 card to go with it and
shoved them into my ultrafast VX MB (cough). I then ran hdparm
to see how fast the sucker could get and got this:

[02:02:24] root@gozer:/root>> free; hdparm -tT /dev/hde; free
             total       used       free     shared    buffers     cached
Mem:         94520      91760       2760          0      63272       6780
-/+ buffers/cache:      21708      72812
Swap:       266032          4     266028

/dev/hde:
 Timing buffer-cache reads:   128 MB in  3.54 seconds = 36.16 MB/sec
 Timing buffered disk reads:  64 MB in  3.13 seconds = 20.45 MB/sec
Hmm.. suspicious results: probably not enough free memory for a proper test.
             total       used       free     shared    buffers     cached
Mem:         94520      91828       2692          0      63608       6524
-/+ buffers/cache:      21696      72824
Swap:       266032         12     266020

Now... that suspicious results note makes me ponder that the results
aren't for real but... if they are, gawddamn. That's more then I hoped
for. 8)

Also, as an aside question, I want to get as much capacity out of this
HD as possible, back and windows compatability be damned. It's currently
in LBA mode (I believe) and that, to my knowledge, wastes the most space.
Is there anything I can do to get more of my HD back for use?

[02:02:41] root@gozer:/root>> hdparm -i /dev/hde

/dev/hde:

 Model=IBM-DTLA-307045, FwRev=TX6OA50C, SerialNo=YMDYMT8X423
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=3(DualPortCache), BuffSize=1916kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=90069840
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2 
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 mode3 mode4 *mode5 

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

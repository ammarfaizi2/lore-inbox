Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRKDT6X>; Sun, 4 Nov 2001 14:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278269AbRKDT6L>; Sun, 4 Nov 2001 14:58:11 -0500
Received: from ns.ithnet.com ([217.64.64.10]:23825 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S275224AbRKDT5E>;
	Sun, 4 Nov 2001 14:57:04 -0500
Date: Sun, 4 Nov 2001 20:56:58 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Subject: Re: Adaptec vs Symbios performance
Message-Id: <20011104205658.3ac97e2d.skraw@ithnet.com>
In-Reply-To: <200111041913.fA4JDKY69597@aslan.scsiguy.com>
In-Reply-To: <20011104193520.1867ae7e.skraw@ithnet.com>
	<200111041913.fA4JDKY69597@aslan.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Nov 2001 12:13:20 -0700 "Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> >Hm, what more specific can I tell you, than:
> 
> Well, the numbers paint a different picture than your pervious
> comments.  You never mentioned a performance disparity, only a
> loss in interactive performance.

See:

Date:	Wed, 31 Oct 2001 16:45:39 +0100
From:	Stephan von Krawczynski <skraw@ithnet.com>
To:	linux-kernel <linux-kernel@vger.kernel.org>
Subject: The good, the bad & the ugly (or VM, block devices, and SCSI :-)
Message-Id: <20011031164539.29c04ee0.skraw@ithnet.com>

> A full dmesg would be better.  Right now I have no idea what kind
> of aic7xxx controller you are using,

Adaptec A29160 (see above mail). Remarkably is I have a 32 bit PCI bus, no 64
bit. This is an Asus CUV4X-D board.


> the speed and type of CPU,

2 x PIII 1GHz

> the chipset in the machine,

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
(rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x
AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev
40)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
00:09.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:0a.0 Network controller: Elsa AG QuickStep 1000 (rev 01)
00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c1010
Ultra3 SCSI Adapter (rev 01)
00:0b.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c1010
Ultra3 SCSI Adapter (rev 01)
00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
00:0d.1 Input device controller: Creative Labs SB Live! (rev 07)
01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev b2)
02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41)
02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41)
02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41)
02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 41)

> Were both tests performed from cold boot

I rechecked that several times, made no difference.

> to a new file in the same
> directory with similar amounts of that filesystem in use?

yes. There is no difference if the file is a) new or b) overwritten. Anyway
both test cases use the same filesystems, I really exchanged only the
controllers, everything else is completely the same. 
Just did another test run with symbios, _after_ heavy nfs and I/O action on the
box and about 145 MB in swap currently. Result: 3620,1 kB/s. _Very_ stable
appearance from symbios.

> >No special stuff or background processes or anything else involved. I wonder
> >how much simpler a test could be.
> 
> It doesn't matter how simple it is if you've never mentioned it before.

Sorry, but there was nothing left out on my side. s.a.

> Your tone is somewhat indignant.  Do you not understand why this
> data is important to understanding and correcting the problem?

Sorry for that, this is unintentional. Though my written english may look nice,
keep in mind I am no native english-speaking, so some things may come over a
bit rougher than intended.

> >Give me values to compare from _your_ setup.
> 
> Send me a c1010. 8-)

Sorry, misunderstanding. What I meant was: how fast can you read data from your
cd-rom attached to some adaptec controller?

> >If you redo this test with nfs-load (copy files from some client to your
> >test-box acting as nfs-server) you will end up at 1926 - 2631 kB/s
throughput
> >with aic, but 3395 - 3605 kB/s with symbios.
> 
> What is the interrupt load during these tests?

How can I present you an exact figure on this?

>  Have you verified that
> disconnection is enabled for all devices on the aic7xxx controller?

yes.

> This does not look like an interrupt latency problem.

Based on which thoughts?

Regards,
Stephan



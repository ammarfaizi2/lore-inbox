Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSEQErX>; Fri, 17 May 2002 00:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSEQErW>; Fri, 17 May 2002 00:47:22 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:60426
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315419AbSEQErU>; Fri, 17 May 2002 00:47:20 -0400
Date: Thu, 16 May 2002 21:46:50 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Justin Piszcz <war@starband.net>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: sg in 2.4.18
Message-ID: <20020517044650.GC627@matchmail.com>
Mail-Followup-To: Justin Piszcz <war@starband.net>,
	linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <20020513101050.A3879@coredump.electro-mechanical.com> <3CDFDEAA.A55E2A8F@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 11:41:30AM -0400, Justin Piszcz wrote:
> I have two Plextor 12/10/32A CDRW's.
> 
> IDE 0 - MASTER: HDD
>              SLAVE: Plextor
> IDE 1 - MASTER: Plextor
> 
> I burn two cds at the same time at 12X.
>

I have a yamaha 16x and a nec 24x, both are IDE.

[snip]
> Believe it or not, any combination with the promise controller only yields
> results worse than the setup I've mentioned above.
> 
> I'm not sure why, but any combination you can think of (between the card, and
> 
> two IDE busses on the motherboard) I have tried.
> 
> Any combination involving the promise makes each drive resort to burnproof
> every 5-10 seconds, when I was doing tests, it took about 30-40 minutes to
> burn @ 12X (two cds parellel) due to falling back to burnproof every 5
> seconds or so.
>

Strange, can you read through the thread "A CD with errors (scratches etc.)
blocks the whole system while reading" and see if you are having a similar
problem?

> Also, putting both burners on the same chain currently does not work.
> Because when cdrecord sends the command to FIX the cd after it is done
> burning the data, the command gets sent to both IDE drives causing cdrecord
> to blow up (the burn fails) on the other burner.

Hmm, I wonder in Andre can say anyting about this.

What kernel version are you running?

Can you post the output of lspci?

With both drives running at the same time, each on a seperate cable and
controller, I was able to write without trouble.

00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
00:07.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II]
(rev 01)
00:08.0 VGA compatible controller: Trident Microsystems TGUI 9660/968x/968x
(rev d3)
00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev
01)
00:0a.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 02)
00:0b.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262267AbSIPP1O>; Mon, 16 Sep 2002 11:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262268AbSIPP1N>; Mon, 16 Sep 2002 11:27:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21770 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262267AbSIPP1M>; Mon, 16 Sep 2002 11:27:12 -0400
Date: Mon, 16 Sep 2002 16:32:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Florian Hinzmann <f.hinzmann@hamburg.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       linux-kernel@vger.kernel.org,
       Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
Message-ID: <20020916163206.B23094@flint.arm.linux.org.uk>
References: <1032179595.1191.0.camel@irongate.swansea.linux.org.uk> <XFMail.20020916162624.f.hinzmann@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <XFMail.20020916162624.f.hinzmann@hamburg.de>; from f.hinzmann@hamburg.de on Mon, Sep 16, 2002 at 04:26:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 04:26:24PM +0200, Florian Hinzmann wrote:
> 
> On 16-Sep-2002 Alan Cox wrote:
> > On Mon, 2002-09-16 at 12:17, Florian Hinzmann wrote:
> >> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> >> kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
> >> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> > 
> > Which is the drive reporting a physical media error
> 
> Which seems to exist only while using the named combinations of DMA access
> and kernel versions. While using i.e. 2.4.19 without DMA I can access the same data,
> dd the whole disk to /dev/null or run badblock checks without finding
> any physical media errors.

Let me get this straight.  If you run this exact procedure, what happens?

1. start with DMA turned on
2. dd the whole disk to /dev/null
3. disable DMA
4. dd the whole disk to /dev/null
5. re-enable DMA
6. dd the whole disk to /dev/null
7. disable DMA
8. dd the whole disk to /dev/null

Are you saying that steps 2 and 6 produce a sectoridnotfound error, while
step 4 and 8 works without problem?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


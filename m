Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262173AbSIPOjq>; Mon, 16 Sep 2002 10:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbSIPOjq>; Mon, 16 Sep 2002 10:39:46 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:3824 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262173AbSIPOjo>; Mon, 16 Sep 2002 10:39:44 -0400
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Hinzmann <f.hinzmann@hamburg.de>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
       Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
In-Reply-To: <XFMail.20020916162624.f.hinzmann@hamburg.de>
References: <XFMail.20020916162624.f.hinzmann@hamburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Sep 2002 15:46:35 +0100
Message-Id: <1032187595.1285.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 15:26, Florian Hinzmann wrote:
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
> 
> 2.4.19 should complain, too, if there is a physical error indeed, right?

The "sectoridnotfound" return is from the drive. That makes it very hard
to believe it isnt a physical error


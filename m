Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262398AbSIPQIa>; Mon, 16 Sep 2002 12:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262429AbSIPQI3>; Mon, 16 Sep 2002 12:08:29 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:37289 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262398AbSIPQI3> convert rfc822-to-8bit; Mon, 16 Sep 2002 12:08:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
Date: Mon, 16 Sep 2002 18:13:05 +0200
X-Mailer: KMail [version 1.4]
References: <XFMail.20020916162624.f.hinzmann@hamburg.de> <1032187595.1285.13.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1032187595.1285.13.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209161813.05842.jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 16. September 2002 16:46 schrieb Alan Cox:
> On Mon, 2002-09-16 at 15:26, Florian Hinzmann wrote:
> > On 16-Sep-2002 Alan Cox wrote:
> > > On Mon, 2002-09-16 at 12:17, Florian Hinzmann wrote:
> > >> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete
> > >> DataRequest Error } kernel: hdb: read_intr: error=0x10 {
> > >> SectorIdNotFound }, LBAsect=97567071, high=5, lo kernel: hdb:
> > >> read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> > >
> > > Which is the drive reporting a physical media error
> >
> > Which seems to exist only while using the named combinations of DMA
> > access and kernel versions. While using i.e. 2.4.19 without DMA I can
> > access the same data, dd the whole disk to /dev/null or run badblock
> > checks without finding any physical media errors.
> >
> > 2.4.19 should complain, too, if there is a physical error indeed, right?
>
> The "sectoridnotfound" return is from the drive. That makes it very hard
> to believe it isnt a physical error

Is the LBA sector number in the error coming from the drive?

Is the drive addressed with LBA or CHS?

Is it possible that this error occurs if the LBA (or CHS) is out of bound? 
(e.g. 40GB drive shouldn't have sector 97567071)


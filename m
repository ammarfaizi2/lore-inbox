Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262429AbSIPQO4>; Mon, 16 Sep 2002 12:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbSIPQO4>; Mon, 16 Sep 2002 12:14:56 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:30990 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S262429AbSIPQOy>; Mon, 16 Sep 2002 12:14:54 -0400
Message-Id: <200209161619.SAA25252@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Florian Hinzmann" <f.hinzmann@hamburg.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 16 Sep 2002 18:19:34 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <1032187595.1285.13.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Sep 2002 15:46:35 +0100, Alan Cox wrote:

>On Mon, 2002-09-16 at 15:26, Florian Hinzmann wrote:

>> > On Mon, 2002-09-16 at 12:17, Florian Hinzmann wrote:
>> >> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
>> >> kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
>> >> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
>> > 
>> > Which is the drive reporting a physical media error
>> 
>> Which seems to exist only while using the named combinations of DMA access
>> and kernel versions. While using i.e. 2.4.19 without DMA I can access the same data,
>> dd the whole disk to /dev/null or run badblock checks without finding
>> any physical media errors.
>> 
>> 2.4.19 should complain, too, if there is a physical error indeed, right?
>
>The "sectoridnotfound" return is from the drive. That makes it very hard
>to believe it isnt a physical error

It might be a seek beyond end-of-media error as well (see ATA spec for
error reporting in this case: either ABRT or IDNF shall be set)!

Ciao,
  Dani



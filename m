Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTDVIEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbTDVIEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:04:09 -0400
Received: from b071133.adsl.hansenet.de ([62.109.71.133]:35077 "EHLO
	b071133.adsl.hansenet.de") by vger.kernel.org with ESMTP
	id S262987AbTDVIEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 04:04:04 -0400
Date: Tue, 22 Apr 2003 10:16:07 +0200
From: Florian Hinzmann <f.hinzmann@hamburg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org,
       jan-hinnerk_reichert@hamburg.de
Subject: problem solved - late answer.. (was: Re: DMA problems w/ PIIX3 IDE,
 2.4.20-pre4-ac2)
Message-Id: <20030422101607.6bf1c30e.f.hinzmann@hamburg.de>
In-Reply-To: <1032187595.1285.13.camel@irongate.swansea.linux.org.uk>
References: <XFMail.20020916162624.f.hinzmann@hamburg.de>
	<1032187595.1285.13.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Quite some months ago I raised some questions, got some answers and 
continued working silently until my problem was solved. While digging 
the archives for yet another IDE problem today I realized I did
not send any message to you guys nor to the list afterwards.

Just in case someone is interested or cares still:

1) Sorry for not sending a "problem solved" mail when it was solved
2) My box is running smoothly again. It was neither a kernel issue
   nor a hardware problem with the disks. Different kernel versions 
   did behave differently, but the cause of it all seems to be a broken
   CPU (or broken jumper settings). 
   Installing a new CPU made all problems go away. And the box is
   rock solid with or without IDE-DMA turned on.


    Regards
        Florian
   

P.S: A little block quoted below in case someone wants to remember what
     this was about:

On 16 Sep 2002 15:46:35 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mon, 2002-09-16 at 15:26, Florian Hinzmann wrote:
> > 
> > On 16-Sep-2002 Alan Cox wrote:
> > > On Mon, 2002-09-16 at 12:17, Florian Hinzmann wrote:
> > >> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> > >> kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
> > >> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> > > 
> > > Which is the drive reporting a physical media error
> > 
> > Which seems to exist only while using the named combinations of DMA access
> > and kernel versions. While using i.e. 2.4.19 without DMA I can access the same data,
> > dd the whole disk to /dev/null or run badblock checks without finding
> > any physical media errors.
> > 
> > 2.4.19 should complain, too, if there is a physical error indeed, right?
> 
> The "sectoridnotfound" return is from the drive. That makes it very hard
> to believe it isnt a physical error
>

-- 
  Florian Hinzmann                         private: f.hinzmann@hamburg.de
                                            Debian: fh@debian.org
PGP Key / ID: 1024D/B4071A65
Fingerprint : F9AB 00C1 3E3A 8125 DD3F  DF1C DF79 A374 B407 1A65

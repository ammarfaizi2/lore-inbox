Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSFKLYk>; Tue, 11 Jun 2002 07:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317006AbSFKLYj>; Tue, 11 Jun 2002 07:24:39 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:37846 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S317005AbSFKLYi>; Tue, 11 Jun 2002 07:24:38 -0400
Subject: Re: Serverworks OSB4 in impossible state
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Daniela Engert <dani@ngrt.de>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020611064201.9F55DEDBE@mail.medav.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Jun 2002 13:25:25 +0200
Message-Id: <1023794726.23733.375.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Alan, I am cc'ing you on this because I read elsewhere that you want 
osb4-bug@ide.cabal.tm to be forwarded to you, and that address still
bounces]. 

I have tried the following:

- comment out the code that stalls the machine when the condition in
  question is encountered.
- run dd over a couple of good blocks on the CD.
- run dd over the corrupted blocks. This leads now to very similar
  errors as in the PIO case.
- reenable DMA with hdparm, because it is automatically disabled by the
  ide-cd driver if an error occurs (why that? the error has nothing to
  do with DMA here).
- repeat the first dd command on the good blocks and compare the
  results.

The results are identical, thus I cannot verify the "4 byte shift" Alan
has been talking about. Of course this is a CD-ROM only scenario, thus
I can't tell anything about hard disks.

Is it possible that the 4-byte shift occurs only with some particular
(older?) version of the chipset? 

In any case, the condition that usually causes Linux to stall is 
indeed a perfectly valid condition for DMA when the device transfers
less data than it's supposed to. I doubt that hanging the system 
without more detailed checks is the right measure to take there.

Martin
 
-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy






Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSH1Rsj>; Wed, 28 Aug 2002 13:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSH1Rsj>; Wed, 28 Aug 2002 13:48:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:13799 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S316339AbSH1Rsi>; Wed, 28 Aug 2002 13:48:38 -0400
Date: Wed, 28 Aug 2002 19:57:31 +0200
From: Heinz Diehl <hd@cavy.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.32-mm1
Message-ID: <20020828175731.GA316@chiara.cavy.de>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
References: <3D6C500E.426B163A@zip.com.au> <20020828132748.GA7466@chiara.cavy.de> <3D6CFE97.DA554FA9@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6CFE97.DA554FA9@zip.com.au>
Organization: private site in Mannheim/Germany
X-PGP-Key: Use PGP! Get my key at http://piggie:pages@www.cavy.de/hd.key
User-Agent: Mutt/1.5.1i (Linux 2.5.32-mm1 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 28 2002, Andrew Morton wrote:

> How about this?
[....]

Now it compiles and runs fine, thanks!

Although there are several error messages appearing in dmesg related to
ide-scsi, but I guess this is a general 2.5.32 issue:

[....]
hda: SAMSUNG SV4002H, ATA DISK drive
hdc: CD-540E, ATAPI CD/DVD-ROM drive
hdd: CD-W54E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02c7e84, I/O limit 4095Mb (mask 0xffffffff)
hda: host protected area => 1
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=4870/255/63, UDMA(33)
hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
hdc:ide-scsi: unsup command: dev 16:00: REQ_CMD REQ_STARTED sector 0, 
 nr/cnr 8/1
  
  end_request: I/O error, dev 16:00, sector 0
  Buffer I/O error on device ide1(22,0), logical block 0
  ide-scsi: unsup command: dev 16:00: REQ_CMD REQ_STARTED sector 1, nr/cnr
  7/1
  
  end_request: I/O error, dev 16:00, sector 1
  Buffer I/O error on device ide1(22,0), logical block 1
  ide-scsi: unsup command: dev 16:00: REQ_CMD REQ_STARTED sector 2, nr/cnr
  6/1
  
  end_request: I/O error, dev 16:00, sector 2
  Buffer I/O error on device ide1(22,0), logical block 2

[....]

-- 
# Heinz Diehl, 68259 Mannheim, Germany

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbTCZSgc>; Wed, 26 Mar 2003 13:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261623AbTCZSgc>; Wed, 26 Mar 2003 13:36:32 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:55248 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261407AbTCZSgb>; Wed, 26 Mar 2003 13:36:31 -0500
Subject: Re: Can not open '/dev/sg0' - attach failed.
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Norbert Wolff <norbert_wolff@t-online.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030326173446.3980a177.norbert_wolff@t-online.de>
References: <20030326173446.3980a177.norbert_wolff@t-online.de>
Content-Type: text/plain
Organization: 
Message-Id: <1048704454.598.11.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 26 Mar 2003 19:47:34 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 18:34, Norbert Wolff wrote:
> On Wed, 26 Mar 2003 21:00:22 +0530
> "Subramanian, M (MED)" <M.Subramanian@geind.ge.com> wrote:
> 
> > cdrecord error
> > ==============
> > 
> > scsibus: 1 target: 0 lun: 0
> > Cannot open '/dev/sg0'
> > 
> > lsmod
> > 
> > Module                  Size  Used by
> > sg                     26688   0 
> > ide-scsi                8352   0 
> > ide-cd                 26848   0 
> > cdrom                  27232   0  [ide-cd]
> 
> High !
> 
> Your cdrom-Module seems to use the ide-cd-driver, so cdrecord's lib which needs 
> SCSI-emulation for IDE-Drives (I think your CD-RW is an IDE-one ?) cannot work.
> 
> You need to load the sr-Driver (Driver for SCSI-CDRoms) instead of the
> ide-cd-driver.

Maybe he should boot the kernel with "hdx=ide-scsi" appended to force
using IDE-SCSI emulation on his CD-RW drive.

Another possibility is reconfiguring cdrecord to use "ATAPI=" or
"/dev/hdx" device naming conventions, thus using ATAPI instead of 
IDE-SCSI. I have been doing this as IDE-SCSI in 2.5 is not stable
enough.
> 
> ______________________________________________________________________
>        Felipe Alfaro Solana
>    Linux Registered User #287198
> http://counter.li.org


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbRGLWHG>; Thu, 12 Jul 2001 18:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266867AbRGLWG4>; Thu, 12 Jul 2001 18:06:56 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:52518 "EHLO
	porkkala.cs159246.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S266797AbRGLWGv>; Thu, 12 Jul 2001 18:06:51 -0400
Message-ID: <3B4E1F6E.23BD5B77@pp.htv.fi>
Date: Fri, 13 Jul 2001 01:06:38 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Luc Lalonde <llalonde@giref.ulaval.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Adaptec SCSI driver lockups
In-Reply-To: <3B4E14E4.BF0497@giref.ulaval.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luc Lalonde wrote:
> 
> I suspect that it is a problem with the Adaptec 39160 SCSI controller
> that is on my system (aic799).  The lockups always occur when I'm
> backing up to my HP DAT40 that is connected to channel A of this SCSI

Our HP DAT (24 GB) occasionally locks up. This doesn't lead to system
lockup, but it's probably because there are no HDDs connected to SCSI bus.
Resetting the DAT (by cycling power) doesn't help, the SCSI
controller/driver gets somehow confused. It requires hardware reset.

This happened also with OpenBSD, although power cycling the DAT fixed the
situation there. I believe it's either buggy software in DAT drive or the
drive is breaking up (those thingies seem to last for about two years). (Or
there is some other SCSI hardware related issue.)

I have tested this with 2940/2930 cards. I think it could lead to system
lockup if there were SCSI HDD with swap connected to same controller.

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

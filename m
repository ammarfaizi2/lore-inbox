Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292396AbSBPPCs>; Sat, 16 Feb 2002 10:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292394AbSBPPCj>; Sat, 16 Feb 2002 10:02:39 -0500
Received: from host194.steeleye.com ([216.33.1.194]:4875 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292393AbSBPPCW>; Sat, 16 Feb 2002 10:02:22 -0500
Message-Id: <200202161502.g1GF2DR01735@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Daniel Phillips <phillips@bonn-fries.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support 
In-Reply-To: Message from Daniel Phillips <phillips@bonn-fries.net> 
   of "Sat, 16 Feb 2002 11:20:33 +0100." <E16c1xJ-0002qR-00@starship.berlin> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Feb 2002 10:02:13 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 07:26 pm, James Bottomley wrote:
> A problem (that is probably only an issue for older drives) is that while 
> technically the standard requires all 3 types of TAG to be supported if tag 
> queueing is, some drives really only have simple tag support in their 
> firmware, so you may need to add a blacklist for ordered tags on certain 
> drives.

phillips@bonn-fries.net said:
> From user space, I hope. 

Well, following the current SCSI black/white list procedure, they would be in 
the static device_list table in scsi_scan.c, so no.

I agree that it's not a nice or friendly thing (and is certainly prone to 
delays when you have to get entries into the actual kernel code), but fixing 
this particular annoyance of the scsi subsystem (although I have actually 
thought about doing it) would be a project separate from the queue barrier 
support.

James






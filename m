Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSBISrg>; Sat, 9 Feb 2002 13:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284180AbSBISr0>; Sat, 9 Feb 2002 13:47:26 -0500
Received: from host194.steeleye.com ([216.33.1.194]:1041 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S282902AbSBISrW>; Sat, 9 Feb 2002 13:47:22 -0500
Message-Id: <200202091847.g19IlIq02443@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Pavel Machek <pavel@suse.cz>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5.3] support for NCR voyager 
In-Reply-To: Message from Pavel Machek <pavel@suse.cz> 
   of "Sat, 09 Feb 2002 19:00:58 +0100." <20020209180057.GB113@elf.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Feb 2002 13:47:18 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@suse.cz said:
> Maybe you should stop calling it new architecture? Its mostly
> i386-compatible, right? 

It's x86 based, and like all good x86 machines, it has a mode where it will 
boot on a single CPU and look like a microchannel PC.  However, the voyagers 
were designed to be large multi-CPU SMP machines.  For SMP, it is completely 
incompatible with the APIC/IO-APIC architecture which linux supports, so the 
voyager patches provide a completely different SMP HAL, which had to be 
written from scratch; it's not merely a modification of the existing one.

> BTW are those "current" machines, or is their production already
> stopped? 

I believe the last data centre machines (the 32 CPU 51xx series) rolled off 
NCR's production lines in 2001, so it is pretty much an obsolete machine now.

James



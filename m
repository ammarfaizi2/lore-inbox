Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSHQRQy>; Sat, 17 Aug 2002 13:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSHQRQx>; Sat, 17 Aug 2002 13:16:53 -0400
Received: from host194.steeleye.com ([216.33.1.194]:8205 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318028AbSHQRQv>; Sat, 17 Aug 2002 13:16:51 -0400
Message-Id: <200208171720.g7HHKim03809@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Gabriel Paubert <paubert@iram.es>
cc: Ingo Molnar <mingo@elte.hu>,
       James Bottomley <James.Bottomley@HansenPartnership.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es> 
   of "Sat, 17 Aug 2002 19:09:26 +0200." <3D5E8346.5010101@iram.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Aug 2002 12:20:44 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paubert@iram.es said:
> Hey no, it's cpu_gdt_table that must be aligned. That one does not
> matter,  it's only used once for the lgdt instruction... 

Actually, the intel manual recommends (but doesn't require) a wierd alignment 
for the descriptors.  It recommends aligning them at an address which is 2 MOD 
4 to avoid possible alignment check faults in user mode.  Not that I think we 
can ever run into the problem, but we should probably obey the recommendation. 
 I'll fix this up as well.

James



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318064AbSHQSXU>; Sat, 17 Aug 2002 14:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSHQSXU>; Sat, 17 Aug 2002 14:23:20 -0400
Received: from gra-vd1.iram.es ([150.214.224.250]:30652 "EHLO gra-vd1.iram.es")
	by vger.kernel.org with ESMTP id <S318064AbSHQSXT>;
	Sat, 17 Aug 2002 14:23:19 -0400
Message-ID: <3D5E9570.2090908@iram.es>
Date: Sat, 17 Aug 2002 20:26:56 +0200
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.0.0) Gecko/20020531
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@HansenPartnership.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
References: <200208171720.g7HHKim03809@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

> 
> 
> Actually, the intel manual recommends (but doesn't require) a wierd alignment 
> for the descriptors.  It recommends aligning them at an address which is 2 MOD 
> 4 to avoid possible alignment check faults in user mode.  Not that I think we 
> can ever run into the problem, but we should probably obey the recommendation. 
>  I'll fix this up as well.

This is already done for the IDT descriptor, but not (yet) for the gdt 
descriptor(s).

Alignment checks are only done when CPL==3. And lidt/lgdt are (obviously) 
privileged, although sidt/sgdt (and sldt/str for that matter) are not,
but I can't see how application could take benefit or make malicious use
of this capability.

	Gabriel.





Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130178AbRBOV3H>; Thu, 15 Feb 2001 16:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130180AbRBOV25>; Thu, 15 Feb 2001 16:28:57 -0500
Received: from colorfullife.com ([216.156.138.34]:33037 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130178AbRBOV2s>;
	Thu, 15 Feb 2001 16:28:48 -0500
Message-ID: <3A8C4A27.9AE0F7D9@colorfullife.com>
Date: Thu, 15 Feb 2001 22:29:11 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac13 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <3A8C254F.17334682@colorfullife.com> <200102151905.LAA62688@google.engr.sgi.com> <20010215201945.A2505@pcep-jamie.cern.ch> <96heaj$bvs$1@penguin.transmeta.com> <3A8C499A.E0370F63@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> I just benchmarked a single flush_tlb_page().
> 
> Pentium II 350: ~ 2000 cpu ticks.
> Pentium III 850: ~ 3000 cpu ticks.
>
I forgot the important part:
SMP, including a smp_call_function() IPI.

IIRC Ingo wrote that a local 'invplg' is around 100 ticks.

--
	Manfred

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289357AbSA2KOP>; Tue, 29 Jan 2002 05:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289330AbSA2KOG>; Tue, 29 Jan 2002 05:14:06 -0500
Received: from sun.fadata.bg ([80.72.64.67]:13063 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S289363AbSA2KNy>;
	Tue, 29 Jan 2002 05:13:54 -0500
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org>
	<87lmehft5b.fsf@fadata.bg> <E16VU2h-00009Y-00@starship.berlin>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
Date: 29 Jan 2002 11:20:13 +0200
In-Reply-To: <E16VU2h-00009Y-00@starship.berlin>
Message-ID: <87g04pfr8y.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:

Daniel> On January 29, 2002 09:39 am, Momchil Velikov wrote:
>> >>>>> "Oliver" == Oliver Xymoron <oxymoron@waste.org> writes:
Oliver> you can't actually _share_ the page tables without marking the pages
Oliver> themselves readonly.
>> 
>> Of course, ptes are made COW, just like now. Which brings up the
>> question how much speedup we'll gain with a code that touches every
>> single pte anyway ?

Daniel> It's only touching the ptes on tables that are actually used, so if a parent
Daniel> with a massive amount of mapped memory forks a child that only instantiates
Daniel> a small portion of it (common situation) then the saving is pretty big.

Umm, all the ptes af the parent ought to be made COW, no ?


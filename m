Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289363AbSA2KRf>; Tue, 29 Jan 2002 05:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289379AbSA2KR0>; Tue, 29 Jan 2002 05:17:26 -0500
Received: from sun.fadata.bg ([80.72.64.67]:13831 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S289363AbSA2KRQ>;
	Tue, 29 Jan 2002 05:17:16 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org>
	<87lmehft5b.fsf@fadata.bg> <E16VU2h-00009Y-00@starship.berlin>
	<20020129012007.H899@holomorphy.com>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020129012007.H899@holomorphy.com>
Date: 29 Jan 2002 12:18:42 +0200
Message-ID: <87ofjd794t.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "William" == William Lee Irwin <wli@holomorphy.com> writes:

William> On Tue, Jan 29, 2002 at 09:55:02AM +0100, Daniel Phillips wrote:
>> It's only touching the ptes on tables that are actually used, so if a parent
>> with a massive amount of mapped memory forks a child that only instantiates
>> a small portion of it (common situation) then the saving is pretty big.

William> Please correct my attempt at clarifying this:
William> The COW markings are done at the next higher level of hierarchy above
William> the pte's themselves, and so experience the radix tree branch factor
William> reduction in the amount of work done at fork-time in comparison to a
William> full pagetable copy on fork.

COW at pgd/pmd level is ia32-ism, unlike COW at pte level.

Regards,
-velco

PS. Well, the whole pgd/pmd/ptb stuff is ia32-ism, but that's another
story.


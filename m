Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289844AbSA2TzJ>; Tue, 29 Jan 2002 14:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289853AbSA2TzA>; Tue, 29 Jan 2002 14:55:00 -0500
Received: from holomorphy.com ([216.36.33.161]:42142 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289844AbSA2Tyt>;
	Tue, 29 Jan 2002 14:54:49 -0500
Date: Tue, 29 Jan 2002 11:55:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Momchil Velikov <velco@fadata.bg>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: Note describing poor dcache utilization under high memory pressure
Message-ID: <20020129115548.J899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Momchil Velikov <velco@fadata.bg>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Oliver Xymoron <oxymoron@waste.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Josh MacDonald <jmacd@CS.Berkeley.EDU>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	reiserfs-list@namesys.com, reiserfs-dev@namesys.com
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org> <87lmehft5b.fsf@fadata.bg> <E16VU2h-00009Y-00@starship.berlin> <20020129012007.H899@holomorphy.com> <87ofjd794t.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <87ofjd794t.fsf@fadata.bg>; from velco@fadata.bg on Tue, Jan 29, 2002 at 12:18:42PM +0200
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"William" == William Lee Irwin <wli@holomorphy.com> writes:
William> Please correct my attempt at clarifying this:
William> The COW markings are done at the next higher level of hierarchy above
William> the pte's themselves, and so experience the radix tree branch factor
William> reduction in the amount of work done at fork-time in comparison to a
William> full pagetable copy on fork.

On Tue, Jan 29, 2002 at 12:18:42PM +0200, Momchil Velikov wrote:
> COW at pgd/pmd level is ia32-ism, unlike COW at pte level.

Pain! Well, at least the pte markings dodge the page_add_rmap() bullet.

On Tue, Jan 29, 2002 at 12:18:42PM +0200, Momchil Velikov wrote:
> PS. Well, the whole pgd/pmd/ptb stuff is ia32-ism, but that's another
> story.

Perhaps something can be done about that.


Cheers,
Bill

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293725AbSBRE0e>; Sun, 17 Feb 2002 23:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293727AbSBRE0Z>; Sun, 17 Feb 2002 23:26:25 -0500
Received: from holomorphy.com ([216.36.33.161]:54404 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S293725AbSBRE0P>;
	Sun, 17 Feb 2002 23:26:15 -0500
Date: Sun, 17 Feb 2002 20:25:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>, riel@surriel.com,
        linux-kernel@vger.kernel.org, rsf@us.ibm.com, marcelo@conectiva.com.br,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, akpm@zip.com.au
Subject: Re: [TEST] page tables filling non-highmem
Message-ID: <20020218042543.GO832@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>, riel@surriel.com,
	linux-kernel@vger.kernel.org, rsf@us.ibm.com,
	marcelo@conectiva.com.br, torvalds@transmeta.com,
	alan@lxorguk.ukuu.org.uk, akpm@zip.com.au
In-Reply-To: <20020215045106.GB26322@holomorphy.com> <E16beDZ-0002jy-00@starship.berlin> <20020218023800.A23743@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020218023800.A23743@athlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 02:38:00AM +0100, Andrea Arcangeli wrote:
> My tree doesn't lock up hard even without pte-highmem applied.  The task
> gets killed. backout pte-highmem, try the same testcase again on my tree
> and you'll see. The oom handling in mainline is deadlock prone, I always
> known this and that's why I always rejected it. Nobody but me
> acklowledged this problem and I spent quite an amount of time convincing
> mainline maintainers about those deadlock flaws of the mainline approch
> but I failed so I giveup waiting for a report like this, just like with
> all the other stuff that is now in my vm patch, 90% of it I tried to
> push it separately into mainline before having to accumulate it.

Actually I'm a little more skeptical on a second reading:

(1) Which of the 1024 processes will it shoot again?
(2) Where is the OOM trigger again?
(3) Where is the accounting on space usage for page tables again?
(4) What is done to counteract the occcasional unswappable allocation
	satisfied from ZONE_NORMAL exerting pressure over time again?

... and this isn't exactly a report, this is a testcase that takes down
machines without the appropriate fixes on demand in order to provide an
adequate demonstration of how some real-life workloads crash the kernel.

Hopefully I left out enough details to slow down the less ethical people;
if I didn't then I'm willing to hear advice on how to handle these things.
Alan, Linus, if there are recommended methods or fora, please let me know.

If I didn't know of pte-highmem already I would never had posted this in
a public forum until some kind of fix existed.

Also, if there are more blatant bugs like this one waiting for fixes
from your VM patch I would be very interested in getting a list
(privately) so that some kind of effort can be devoted to both pushing
the fixes to mainline and making sure these bugs either don't arise or
get fixed in -rmap.

Please send it encrypted.


Cheers,
Bill

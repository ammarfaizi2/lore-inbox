Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292520AbSCAAeW>; Thu, 28 Feb 2002 19:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293487AbSCAAaW>; Thu, 28 Feb 2002 19:30:22 -0500
Received: from are.twiddle.net ([64.81.246.98]:31124 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S310273AbSCAA0W>;
	Thu, 28 Feb 2002 19:26:22 -0500
Date: Thu, 28 Feb 2002 16:24:22 -0800
From: Richard Henderson <rth@twiddle.net>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        matthew@hairy.beasts.org, bcrl@redhat.com, david@mysql.com,
        wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020228162422.A947@twiddle.net>
Mail-Followup-To: Hubertus Franke <frankeh@watson.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	matthew@hairy.beasts.org, bcrl@redhat.com, david@mysql.com,
	wli@holomorphy.com, linux-kernel@vger.kernel.org
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au> <20020225100025.A1163@elinux01.watson.ibm.com> <20020227112417.3a302d31.rusty@rustcorp.com.au> <20020227105311.C838@elinux01.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020227105311.C838@elinux01.watson.ibm.com>; from frankeh@watson.ibm.com on Wed, Feb 27, 2002 at 10:53:11AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 10:53:11AM -0500, Hubertus Franke wrote:
> As stated above, I allocate a kernel object <kulock_t> on demand and
> hash it. This way I don't have to pin any user address. What does everybody
> think about the merit of this approach versus the pinning approach?
[...]
> In your case, can the lock be allocated at different
> virtual addresses in the various address spaces.

I think this is a relatively important feature.  It may not be
possible to use the same virtual address in different processes.


r~

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTBTJKl>; Thu, 20 Feb 2003 04:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbTBTJKl>; Thu, 20 Feb 2003 04:10:41 -0500
Received: from newpeace.netnation.com ([204.174.223.7]:40616 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S264984AbTBTJKj>; Thu, 20 Feb 2003 04:10:39 -0500
Date: Thu, 20 Feb 2003 01:20:43 -0800
From: Simon Kirby <sim@netnation.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, davem@redhat.com
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Message-ID: <20030220092043.GA25527@netnation.com>
References: <20030219174757.GA5373@netnation.com.suse.lists.linux.kernel> <p73r8a3xub5.fsf@amdsimf.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r8a3xub5.fsf@amdsimf.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 08:52:46AM +0100, Andi Kleen wrote:

> That's probably because of the lazy ICMP socket locking used for the
> ICMP socket. When an ICMP is already in process the next ICMP triggered
> from a softirq (e.g. ECHO-REQUEST) is dropped  
> (see net/ipv4/icmp_xmit_lock_bh())

Hmm...and this is considered desired behavior?  It seems like an odd way
of handling packets intended to test latency and reliability. :)

This is most likely the cause, but I will test tomorrow to confirm.

Thanks,

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]

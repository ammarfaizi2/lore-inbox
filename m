Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTBTJYW>; Thu, 20 Feb 2003 04:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTBTJYW>; Thu, 20 Feb 2003 04:24:22 -0500
Received: from ns.suse.de ([213.95.15.193]:44045 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265008AbTBTJYV>;
	Thu, 20 Feb 2003 04:24:21 -0500
Date: Thu, 20 Feb 2003 10:34:22 +0100
From: Andi Kleen <ak@suse.de>
To: Simon Kirby <sim@netnation.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, davem@redhat.com
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Message-ID: <20030220093422.GA16369@wotan.suse.de>
References: <20030219174757.GA5373@netnation.com.suse.lists.linux.kernel> <p73r8a3xub5.fsf@amdsimf.suse.de> <20030220092043.GA25527@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220092043.GA25527@netnation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 01:20:43AM -0800, Simon Kirby wrote:
> On Thu, Feb 20, 2003 at 08:52:46AM +0100, Andi Kleen wrote:
> 
> > That's probably because of the lazy ICMP socket locking used for the
> > ICMP socket. When an ICMP is already in process the next ICMP triggered
> > from a softirq (e.g. ECHO-REQUEST) is dropped  
> > (see net/ipv4/icmp_xmit_lock_bh())
> 
> Hmm...and this is considered desired behavior?  It seems like an odd way
> of handling packets intended to test latency and reliability. :)

IP is best-effort. Dropping packets in odd cases to make locking simpler
is not unreasonable. Would you prefer an slower kernel?

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTBUKM5>; Fri, 21 Feb 2003 05:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267299AbTBUKM4>; Fri, 21 Feb 2003 05:12:56 -0500
Received: from ns.suse.de ([213.95.15.193]:28933 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267292AbTBUKMz>;
	Fri, 21 Feb 2003 05:12:55 -0500
Date: Fri, 21 Feb 2003 11:22:58 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, sim@netnation.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Message-ID: <20030221102257.GA10108@wotan.suse.de>
References: <20030220093422.GA16369@wotan.suse.de> <20030220.202438.10564686.davem@redhat.com> <20030221072719.GD25144@wotan.suse.de> <20030221.014316.69598293.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221.014316.69598293.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The big problem is that we have one ICMP socket for UP and only
> one for SMP too.  That's just dumb, we should make this be a
> per-cpu thing.

Doesn't work on preemptive, does it? How do you keep it on a single CPU
when it runs in process context ?

-Andi

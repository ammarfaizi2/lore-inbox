Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268321AbTBWKUd>; Sun, 23 Feb 2003 05:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268310AbTBWKUd>; Sun, 23 Feb 2003 05:20:33 -0500
Received: from ns.suse.de ([213.95.15.193]:28946 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268308AbTBWKUb>;
	Sun, 23 Feb 2003 05:20:31 -0500
Date: Sun, 23 Feb 2003 11:30:39 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, ak@suse.de, sim@netnation.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Message-ID: <20030223103039.GA19725@wotan.suse.de>
References: <20030221104541.GA18417@wotan.suse.de> <20030223.011217.04700323.davem@redhat.com> <20030223100234.B15347@infradead.org> <20030223.015511.63413067.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030223.015511.63413067.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 01:55:11AM -0800, David S. Miller wrote:
>    From: Christoph Hellwig <hch@infradead.org>
>    Date: Sun, 23 Feb 2003 10:02:34 +0000
> 
>    On Sun, Feb 23, 2003 at 01:12:17AM -0800, David S. Miller wrote:
>    > +static struct socket *__icmp_socket[NR_CPUS];
>    > +#define icmp_socket	__icmp_socket[smp_processor_id()]
>    
>    This should be per-cpu data
>    
> My bad.  Thanks for spotting this.

Won't work if the IPv4 code is ever made modular.

-Andi

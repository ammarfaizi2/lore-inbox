Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270684AbRHJXtd>; Fri, 10 Aug 2001 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270688AbRHJXtY>; Fri, 10 Aug 2001 19:49:24 -0400
Received: from wireless-folk-35-95.campsite.hal2001.org ([217.155.35.95]:13218
	"EHLO thefinal.cern.ch") by vger.kernel.org with ESMTP
	id <S270684AbRHJXtQ>; Fri, 10 Aug 2001 19:49:16 -0400
Date: Sat, 11 Aug 2001 00:50:37 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andi Kleen <ak@muc.de>
Cc: Subba Rao <subba9@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Half Duplex and Zero Copy IP
Message-ID: <20010811005037.A5591@thefinal.cern.ch>
In-Reply-To: <20010810095313.A6219@home.com> <k266bveos8.fsf@zero.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <k266bveos8.fsf@zero.aec.at>; from ak@muc.de on Fri, Aug 10, 2001 at 08:46:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The sniffer zero copy implementation as implemented in some libpcaps 
> does not depend on any special NIC support; it should work with any.

Do you mean mmap() on a packet socket?  Unless I am mistaken, the data
is still copied once to the mmap area, however only the capture length
is copied -- the rest of the packet is discarded.

This means that you cannot use mmap() on a packet socket to zero-copy
read whole packets.  In fact there is no way to zero-copy read whole
packets into user space, without modifying the kernel.

Am I mistaken (it would be nice)?

Thanks,
-- Jamie

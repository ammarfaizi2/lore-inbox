Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbTCYMcl>; Tue, 25 Mar 2003 07:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbTCYMck>; Tue, 25 Mar 2003 07:32:40 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:28853 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262600AbTCYMch>; Tue, 25 Mar 2003 07:32:37 -0500
Date: Tue, 25 Mar 2003 12:43:33 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org
Subject: Re: cacheline size detection code in 2.5.66
Message-ID: <20030325124333.GB28451@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andi Kleen <ak@muc.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
References: <20030325071532.GA19217@averell> <20030325143310.A3487@jurassic.park.msu.ru> <20030325121527.GA29965@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325121527.GA29965@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 01:15:27PM +0100, Andi Kleen wrote:

 > > BTW, the "AMD Processor Recognition Application Note" calls bit 19
 > > "Multiprocessing Capable". ;-)
 > Hmm, yes it's broken. 19 is CFLUSH in the 8000_0001 extended CPUID word,
 > but not in index 0000_0001.

On K8 maybe, but on K7, its correct as it stands. bit 19 of 80000001
is the MP capability bit. As K7 never had clflush, its not defined
there.

 > Broken in i386 too.

I don't see anything broken there. The K7 / K8 feature flags are not
bit for bit compatible though iirc (can't find my K8 cpuid manuals right now).

		Dave


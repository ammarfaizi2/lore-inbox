Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTH2KDw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTH2KDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:03:52 -0400
Received: from aneto.able.es ([212.97.163.22]:27358 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264496AbTH2KDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:03:50 -0400
Date: Fri, 29 Aug 2003 12:03:48 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030829100348.GA5417@werewolf.able.es>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>; from jamie@shareable.org on Fri, Aug 29, 2003 at 07:35:10 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.29, Jamie Lokier wrote:
> Dear All,
[...]
> 
> I already got a surprise (to me): my Athlon MP is much slower
> accessing multiple mappings which are within 32k of each other, than
> mappings which are further apart, although it is coherent.  The L1
> data cache is 64k.  (The explanation is easy: virtually indexed,
> physically tagged cache moves data among cache lines, possibly via L2).
> 

Sorry if this is a stupid question, but have you heard about 64K-aliasing ?
We have seen it in P3/P4, do not know if Athlons also suffer it.
In short, x86 is crap. It slows like a dog when accessing two memory
positions sparated by 2^n (address decoder has two 16 bits adders, instead
of 1 32 bits..., cache is 16 bit tagged, etc...)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264521AbTH2Kh6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTH2Kh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:37:58 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:22954 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264521AbTH2Kh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:37:56 -0400
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030829100348.GA5417@werewolf.able.es>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
	 <20030829100348.GA5417@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062153389.26754.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 29 Aug 2003 11:36:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-29 at 11:03, J.A. Magallon wrote:
> Sorry if this is a stupid question, but have you heard about 64K-aliasing ?
> We have seen it in P3/P4, do not know if Athlons also suffer it.
> In short, x86 is crap. It slows like a dog when accessing two memory
> positions sparated by 2^n (address decoder has two 16 bits adders, instead
> of 1 32 bits..., cache is 16 bit tagged, etc...)

Pretty much all processors are bad at handling memory accesses on the
same alignment within powers of two. Thats one of the reasons for slab
and for things like the old kernel code putting skb structs at the end
of the skbuff data.

Grab a copy of "Unix systems for modern architectures".



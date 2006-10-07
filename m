Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932791AbWJGT62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbWJGT62 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbWJGT62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:58:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932791AbWJGT61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:58:27 -0400
Date: Sat, 7 Oct 2006 12:57:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot
 handle IRQ -1"
In-Reply-To: <1160249585.3000.159.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0610071255480.3952@g5.osdl.org>
References: <20061005212216.GA10912@rhun.haifa.ibm.com> 
 <m11wpl328i.fsf@ebiederm.dsl.xmission.com>  <20061006155021.GE14186@rhun.haifa.ibm.com>
  <m1d5951gm7.fsf@ebiederm.dsl.xmission.com>  <20061006202324.GJ14186@rhun.haifa.ibm.com>
  <m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>  <20061007080315.GM14186@rhun.haifa.ibm.com>
  <m14pugxe47.fsf@ebiederm.dsl.xmission.com>  <Pine.LNX.4.64.0610071154510.3952@g5.osdl.org>
 <1160249585.3000.159.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Oct 2006, Arjan van de Ven wrote:
> 
> it seems the right mix at this time is to have the software select the
> package, and the hardware pick the core within the package. 

I think that sounds like a fairly good approach.

Software obviously can make the "rough" selections, it's the fine-grained 
ones that are harder (and might need to be done at a frequency that just 
makes it impractical).

So yes, having software say "We want to steer this particular interrupt to 
this L3 cache domain" sounds eminently sane.

Having software specify which L1 cache domain it wants to pollute is 
likely just crazy micro-management.

		Linus

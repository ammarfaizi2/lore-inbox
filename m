Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbTH2Ssy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTH2Ssx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:48:53 -0400
Received: from aneto.able.es ([212.97.163.22]:44010 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261619AbTH2Sst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:48:49 -0400
Date: Fri, 29 Aug 2003 20:48:47 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
Message-ID: <20030829184847.GA2069@werewolf.able.es>
References: <20030828223511.GA23528@werewolf.able.es> <20030829152418.GB709@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030829152418.GB709@wind.cocodriloo.com>; from wind@cocodriloo.com on Fri, Aug 29, 2003 at 17:24:18 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.29, Antonio Vargas wrote:
> On Fri, Aug 29, 2003 at 12:35:11AM +0200, J.A. Magallon wrote:
[...]
> > 
> > A collateral question: why is the reason for this function ?
> > long long assignments are not atomic in gcc ?
> 
> On x86, long long int == 64 bits but the chip is 32 bits wide,
> so it uses 2 separate memory accesses. There are 64bit-wide
> instructions which do bus-locking so that the are atomic,
> but gcc will not use them directly.
> 

I know, my question was why gcc does not generate cmpxchg8b on
a 64 bits assign. Or it should not ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))

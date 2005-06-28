Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVF1NuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVF1NuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 09:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVF1NuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 09:50:24 -0400
Received: from embeddededge.com ([209.113.146.155]:64778 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S261675AbVF1Nta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 09:49:30 -0400
In-Reply-To: <1119939689.5133.200.camel@gaston>
References: <20050626172334.GA5786@logos.cnet> <20050626164939.2f457bf6.akpm@osdl.org> <20050626185210.GB6091@logos.cnet> <20050626.173338.41634345.davem@davemloft.net> <20050626190944.GC6091@logos.cnet> <6a3846d2436994d94aeacb0b0850d5f5@embeddededge.com> <1119939689.5133.200.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6dcc5f35c031c4d6c8ef1d133e5bb53d@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: increased translation cache footprint in v2.6
Date: Tue, 28 Jun 2005 09:49:18 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 28, 2005, at 2:21 AM, Benjamin Herrenschmidt wrote:

> How so ? the linux page table structure allow you to format the PTE and
> PMD contents pretty much the way you want ...

Pretty much the way, but not exactly :-)

> Paul told me the 8xx has some restrictions about what goes at the "PMD"
> level that is a problem for us (is it cache inhibited bit ?) and thus 
> we
> cannot completely do the PMD/PTE thingy,

There are some page control options that would be easier handled at
the pmd boundary.  Cache mode is one of them.


	-- Dan


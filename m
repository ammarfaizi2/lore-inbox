Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161298AbWHJOxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161298AbWHJOxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161289AbWHJOxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:53:53 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:53890 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161288AbWHJOxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:53:52 -0400
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andy Whitcroft <apw@shadowen.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <44DB4547.80007@shadowen.org>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	 <20060807194159.f7c741b5.akpm@osdl.org>
	 <17624.7310.856480.704542@cargo.ozlabs.ibm.com>
	 <200608080714.21151.ak@suse.de> <1155025073.26277.18.camel@localhost>
	 <20060809175854.GA14382@intel.com>
	 <1155147948.19249.171.camel@localhost.localdomain>
	 <1155214538.14749.54.camel@localhost>  <44DB4547.80007@shadowen.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 10 Aug 2006 16:53:48 +0200
Message-Id: <1155221628.14749.60.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 15:40 +0100, Andy Whitcroft wrote:
> Well you could do something more fun with the top of the address.  You
> don't need to keep the bytes in the same order for instance.  If this
> is really a fair size chunk at the bottom and one at the top then
> taking the address and swapping the bytes like:
> 
>         ABCDEFGH => BCDAEFGH
> 
> Would be a pretty trivial bit of register wibbling (ie very quick),
> but would probabally mean a single flat, smaller sparsemem table would
> cover all likely areas. 

Not if you don't know where the objects will be mapped..

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.



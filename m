Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWCXPkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWCXPkE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWCXPkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:40:04 -0500
Received: from ns.suse.de ([195.135.220.2]:47808 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750950AbWCXPkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:40:01 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in thee820 table
Date: Fri, 24 Mar 2006 16:39:53 +0100
User-Agent: KMail/1.9.1
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <1143138170.3147.43.camel@laptopd505.fenrus.org> <20060324072250.A13756@unix-os.sc.intel.com> <44240F30.10801@linux.intel.com>
In-Reply-To: <44240F30.10801@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241639.54192.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 16:24, Arjan van de Ven wrote:
> Ashok Raj wrote:
> > On Thu, Mar 23, 2006 at 11:15:19AM -0800, Arjan van de Ven wrote:
> >>    >
> >>    > I'll do a new patch using this for x86_64 though, no need to make a
> >>    > second function like this.
> >>
> >>     int  __init  e820_mapped(unsigned  long  start,  unsigned  long  end,
> >>    unsigned type)
> > 
> > 
> > Why not use the same type of function like x86_64 as well instead of the newly
> > added is_820_mapped()? If the purpose of both functions is the same, i386 could benefit 
> > with same style code instead of a slight variant.
> 
> the purpose is not the same. the e820_mapped function is far less strict in its check
> (I'm still afraid it is too weak for this purpose actually)

In theory they should be the same. What do you think is different?

> 
> and it's not is_e820_mapped but is_e820_reserved()

That's just a special case.

-Andi


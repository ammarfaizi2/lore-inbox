Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWHaHqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWHaHqF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 03:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWHaHqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 03:46:05 -0400
Received: from ns.suse.de ([195.135.220.2]:3470 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751013AbWHaHqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 03:46:02 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199" II
Date: Thu, 31 Aug 2006 09:45:58 +0200
User-Agent: KMail/1.9.3
Cc: "Badari Pulavarty" <pbadari@gmail.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, petkov@math.uni-muenster.de,
       akpm@osdl.org, "lkml" <linux-kernel@vger.kernel.org>
References: <20060820013121.GA18401@fieldses.org> <44F6AD47.76E4.0078.0@novell.com> <200608310941.40076.ak@suse.de>
In-Reply-To: <200608310941.40076.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608310945.58728.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 09:41, Andi Kleen wrote:
> On Thursday 31 August 2006 09:35, Jan Beulich wrote:
> > Andi submitted a fix for this to Linus, but that's post-rc5. Jan
> 
> I assume you mean the fallback validation fix. Linus unfortunately
> didn't merge any of my new patches yet :/

To follow myself up. I should have checked HEAD before writing this :/
Linus merged it all last night and I blamed him wrongly, sorry. 
So that problem will be hopefully gone.

For completeness the unwind fixes that went in were:

Jan Beulich 	[PATCH] x86: Make backtracer fallback logic more bullet-proof
Andi Kleen 	[PATCH] i386: Add kernel thread stack frame termination 
Andi Kleen 	[PATCH] x86_64: Add kernel thread stack frame termination 

and this one fixed an additional bug in the old x86-64 unwinder:

Keith Owens 	[PATCH] x86_64: Save original IST values for checking

-Andi


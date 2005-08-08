Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVHHXQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVHHXQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVHHXQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:16:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:60104 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932352AbVHHXQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:16:38 -0400
Date: Tue, 9 Aug 2005 01:16:37 +0200
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Tom Rini <trini@kernel.crashing.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] x86_64: Rename KDB_VECTOR to DEBUGGER_VECTOR
Message-ID: <20050808231637.GA21576@wotan.suse.de>
References: <20050808192850.GQ19170@wotan.suse.de> <19345.1123542892@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19345.1123542892@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 09:14:52AM +1000, Keith Owens wrote:
> On Mon, 8 Aug 2005 21:28:50 +0200, 
> Andi Kleen <ak@suse.de> wrote:
> >On Mon, Aug 08, 2005 at 12:27:10PM -0700, Tom Rini wrote:
> >>  {
> >>  	unsigned int icr =  APIC_DM_FIXED | shortcut | vector | dest;
> >> -	if (vector == KDB_VECTOR)
> >> +	if (vector == NMI_VECTOR)
> >>  		icr = (icr & (~APIC_VECTOR_MASK)) | APIC_DM_NMI;
> >
> >That if () should be removed since it's useless.
> >Can you do that please?
> 
> Why is 'if ()' useless?  Remove the if test and all ipis get sent as
> NMI, we definitely do not want that.

The if () with its following line. The same result can be gotten
by passing suitable arguments.

-Andi

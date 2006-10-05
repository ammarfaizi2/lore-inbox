Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWJESwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWJESwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWJESwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:52:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:12991 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750831AbWJESwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:52:51 -0400
Date: Thu, 5 Oct 2006 14:52:17 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Steve Fox <drfickle@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Message-ID: <20061005185217.GF20551@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060928014623.ccc9b885.akpm@osdl.org> <200610051740.58511.ak@suse.de> <1160071032.29690.19.camel@flooterbu> <200610052027.02208.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610052027.02208.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 08:27:02PM +0200, Andi Kleen wrote:
> On Thursday 05 October 2006 19:57, Steve Fox wrote:
> > On Thu, 2006-10-05 at 17:40 +0200, Andi Kleen wrote:
> > 
> > > Please don't snip the Code: line. It is fairly important.
> > 
> > Sorry about that. The remote console I was using appears to overwrite
> > some text after I force the reboot. Here's a clean one.
> > 
> > global ffffffffffffffff
> 
> Ok that definitely shouldn't be in there.
> 
> I guess we need to track when it gets corrupted. Can you send the full
> boot log with this patch applied?
> 

Just recalled one more observation about the problem when keith had
reported it last. If I just move .bss before .data_nosave instead
of it being at the end, keith's problem had disappeared.

Thanks
Vivek

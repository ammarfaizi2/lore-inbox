Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWFPAua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWFPAua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 20:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWFPAua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 20:50:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:63104 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750809AbWFPAua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 20:50:30 -0400
Subject: Re: [RFC] CPU controllers?
From: Matt Helsley <matthltc@us.ibm.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: vatsa@in.ibm.com, Sam Vilain <sam@vilain.net>,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4491ED7B.2000003@bigpond.net.au>
References: <20060615134632.GA22033@in.ibm.com>
	 <4491ED7B.2000003@bigpond.net.au>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 17:42:49 -0700
Message-Id: <1150418569.21787.456.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-16 at 09:30 +1000, Peter Williams wrote:
> Srivatsa Vaddagiri wrote:

<snip>

> > 	* Supports hard limit and soft limit
> > 	* Introduces new task priorities where tasks that have exceeded their 
> > 	  soft limit can be "parked" until the O(1) scheduler picks them for
> >  	  execution
> > 	* Load balancing on SMP systems made aware of tasks whose execution
> > 	  rate is limited by this feature
> > 	* Patch is simple
> > 
> > Limitations:
> > 	* Does not support guarantee
> 
> Why would a capping mechanism support guarantees?  The two mechanisms 
> can be implemented separately.  The only interaction between them that 
> is required is a statement about which has precedence.  I.e. if a cap is 
> less than a guarantee is it enforced?  I would opine that it should be.

When this combination occurs userspace is crazy/uncoordinated/dumb and
can't be "satisfied". Perhaps the better approach is to ignore both
guarantee and limit (cap) in this case -- treat it as if userspace
hasn't specified either.

Alternatively the kernel can refuse to allow configuring such a
combination in the first place. This is one reason tying guarantees and
limits (caps) into the same framework would be useful.

<snip>

Cheers,
	-Matt Helsley




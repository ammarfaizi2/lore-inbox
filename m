Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUIXAIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUIXAIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUIXAIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:08:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51844 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267598AbUIXAGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:06:33 -0400
Date: Thu, 23 Sep 2004 19:31:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjanv@redhat.com, ak@suse.de,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to fit 32byte cacheline]
Message-ID: <20040923223142.GA13915@logos.cnet>
References: <7F740D512C7C1046AB53446D372001730249590A@scsmsx402.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001730249590A@scsmsx402.amr.corp.intel.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 01:24:49PM -0700, Nakajima, Jun wrote:
> >From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com]
> >Sent: Thursday, September 23, 2004 7:12 AM
> >To: linux-kernel@vger.kernel.org
> >Cc: Nakajima, Jun; akpm@osdl.org; arjanv@redhat.com; ak@suse.de
> >Subject: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to fit
> 32byte
> >cacheline]
> >
> >
> >Forgot to CC linux-kernel, just in case someone else
> >can have useful information on this matter.
> >
> >Andi says any additional overhead will be in the noise
> >compared to cacheline saving benefit.
> >
> >***********
> >
> >Jun,
> >
> >We need some assistance here - you can probably help us.
> >
> >Within the Linux kernel we can benefit from changing some fields
> >of commonly accessed data structures to 16 bit instead of 32 bits,
> >given that the values for these fields never reach 2 ^ 16.
> >
> >Arjan warned me, however, that the prefix (in this case "data16") will
> >cause an additional extra cycle in instruction decoding, per message
> above.
> 
> On the Pentium4 core, this is not a big deal because it runs out of the
> trace cache (i.e. decoded in advance). However, on the Pentium III/M
> (aka P6) core (i.e. Penitum III, Banias, Dothan, Yonah, etc.),
> especially when an operand size prefix (0x66) changes the # of bytes in
> an instruction (usually by impacting the size of an immediate in the
> instruction), the P6 core pays unnegligible penalty, slowing down
> decoding.

Jun,

What you mean by "unnegligible penalty" ? 

You mean its very small penalty (unconsiderable), or its considerable penalty?

We are use one less cacheline for a very commonly used structure. 

Thanks and sorry for poor english :)

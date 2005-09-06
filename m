Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVIFXFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVIFXFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIFXFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:05:12 -0400
Received: from fmr23.intel.com ([143.183.121.15]:42632 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751110AbVIFXFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:05:10 -0400
Date: Tue, 6 Sep 2005 16:04:29 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 14/14] x86_64: Choose physflat for AMD systems only when >8 CPUS.
Message-ID: <20050906160429.A19592@unix-os.sc.intel.com>
References: <200509032135.j83LZ90U020559@shell0.pdx.osdl.net> <20050905231808.GB16476@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050905231808.GB16476@muc.de>; from ak@muc.de on Tue, Sep 06, 2005 at 01:18:08AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 01:18:08AM +0200, Andi Kleen wrote:
> On Sat, Sep 03, 2005 at 02:33:30PM -0700, akpm@osdl.org wrote:
> > 
> > From: Ashok Raj <ashok.raj@intel.com>
> > 
> > It is not required to choose the physflat mode when CPU hotplug is enabled and
> > CPUs <=8 case.  Use of genapic_flat with the mask version is capable of doing
> > the same, instead of doing the send_IPI_mask_sequence() where its a unicast.
> 
> I don't get the reasoning of this change. So probably not.

Hummm...Please see below. Nothing has changed since then, any idea why
its not acceptable now?

http://marc.theaimsgroup.com/?l=linux-kernel&m=112315304423377&w=2

This really doesnt affect me, it just bothers me to go over inefficient code.
send_IPI_mask_sequence() does unicast IPI's. When number of CPUs is <=8
the mask version acheives the same with just one write, so its a selective
broadcast which is more efficient. 

Based on our earlier exchange i assumed it was clear and apparent which is
why you  "OK"ed the version when it was submitted to -mm. 

Nothing has changed, its the exact same patch. Hope its clear now.

Entirely up to you... :-(

-- 
Cheers,
Ashok Raj
- Open Source Technology Center

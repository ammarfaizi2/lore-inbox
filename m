Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWCXPsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWCXPsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWCXPsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:48:20 -0500
Received: from fmr20.intel.com ([134.134.136.19]:11742 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751112AbWCXPsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:48:20 -0500
Date: Fri, 24 Mar 2006 07:48:09 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andi Kleen <ak@suse.de>, Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in thee820 table
Message-ID: <20060324074808.A14035@unix-os.sc.intel.com>
References: <1143138170.3147.43.camel@laptopd505.fenrus.org> <20060324072250.A13756@unix-os.sc.intel.com> <44240F30.10801@linux.intel.com> <200603241639.54192.ak@suse.de> <44241359.3070409@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <44241359.3070409@linux.intel.com>; from arjan@linux.intel.com on Fri, Mar 24, 2006 at 04:42:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 04:42:17PM +0100, Arjan van de Ven wrote:
> Andi Kleen wrote:
> > In theory they should be the same. What do you think is different?
> 
> in practice the x86-64 version returns "success" if there is one byte in the entire
> memory range that complies with the requested type, even if the rest of the range is
> of another type. What the ideal is for the purpose here is "is the entire range reserved",
> but for now I'll settle for "is the start address reserved".
> 
> (and yes you can express the "is the start address reserved" as a question to the current function for
> a 1 byte range, I probably should do that I suppose)

or why not check

if (type == ei->type && start >= ei->addr && end <= (ei->addr + ei->size))
	return 1;

will this make the range check check stricter?
-- 
Cheers,
Ashok Raj
- Open Source Technology Center

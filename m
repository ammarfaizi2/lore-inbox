Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVJHK0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVJHK0q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 06:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbVJHK0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 06:26:46 -0400
Received: from ns2.suse.de ([195.135.220.15]:27617 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750892AbVJHK0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 06:26:46 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [Patch] x86, x86_64: Intel HT, Multi core detection code cleanup
Date: Sat, 8 Oct 2005 12:28:38 +0200
User-Agent: KMail/1.8
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20051005161706.B30098@unix-os.sc.intel.com> <20051007095200.GL6642@verdi.suse.de> <20051007175240.A2354@unix-os.sc.intel.com>
In-Reply-To: <20051007175240.A2354@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081228.39492.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 October 2005 02:52, Siddha, Suresh B wrote:
> On Fri, Oct 07, 2005 at 11:52:00AM +0200, Andi Kleen wrote:
> > > I can fix the API mess. Is there anything else you want me to do?
> >
> > I think you overdid the sharing. Can you limit it to one file
> > and copy the stuff that doesn't fit easily?
>
> Andi, This stuff is very much common to x86 and x86_64. Shared code is
> split into two files because setting up sibling map code is generic and
> HT/core detection code is very specific to Intel.
>
> How about the appended patch?

I would prefer if the Intel CPU detection support wasn't distributed over so 
many small files. If you prefer to share it put it all into a single file and 
share that. But please only for code that can be cleanly shared without 
ifdefs.

Also in general it would be better if you first did the cleanup and then 
as separate patches the various functionality enhancements.That makes
the changes easier to be reviewed and it helps in binary search when something 
goes wrong.

-Andi

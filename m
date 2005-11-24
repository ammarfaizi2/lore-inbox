Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbVKXVUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbVKXVUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 16:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbVKXVUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 16:20:16 -0500
Received: from mx1.suse.de ([195.135.220.2]:61121 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932658AbVKXVUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 16:20:14 -0500
Date: Thu, 24 Nov 2005 22:20:00 +0100
From: Andi Kleen <ak@suse.de>
To: thockin@hockin.org
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124212000.GW20775@brahms.suse.de>
References: <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com> <20051124153635.GJ20775@brahms.suse.de> <20051124191207.GB2468@hockin.org> <20051124191445.GR20775@brahms.suse.de> <20051124192414.GA3670@hockin.org> <20051124192953.GT20775@brahms.suse.de> <20051124194459.GA4069@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124194459.GA4069@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 11:44:59AM -0800, thockin@hockin.org wrote:
> On Thu, Nov 24, 2005 at 08:29:53PM +0100, Andi Kleen wrote:
> > > We implemented AMD's reference algorithm, and made it work in the presence
> > > of a hardware IO hole.  It seems to work beautifully, but the last step is
> > > turning a (node:chip-select) into a (node:dimm).  Simple boards will use
> > > simple mappings, but we can't know that without board specific info.
> > > Especially with quad-rank DIMMs. :)
> > 
> > If you get something working it would be good if you could share the code
> > (even if it still needs to be tweaked) 
> 
> The below code works for us.  Note that I did not implement the
> node-interleaving parts of the AMD algorithm.  If that matters, it should
> be simple enough to do.  The BKDG has good pseudo-code.  The only thing it
> gets absolutely wrong is the IO hole.

Thanks. But without a per board DIMM mapping it's pretty useless, isn't it?

One could detect the IO hole by reading the IORR MSRs or alternatively
parsing the e820 map in /var/log/boot.msg

-Andi


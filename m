Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbVKXVii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbVKXVii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 16:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVKXVii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 16:38:38 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:19407 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932662AbVKXVih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 16:38:37 -0500
Date: Thu, 24 Nov 2005 13:40:10 -0800
From: thockin@hockin.org
To: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
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
Message-ID: <20051124214010.GA17076@hockin.org>
References: <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com> <20051124153635.GJ20775@brahms.suse.de> <20051124191207.GB2468@hockin.org> <20051124191445.GR20775@brahms.suse.de> <20051124192414.GA3670@hockin.org> <20051124192953.GT20775@brahms.suse.de> <20051124194459.GA4069@hockin.org> <20051124212000.GW20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124212000.GW20775@brahms.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 10:20:00PM +0100, Andi Kleen wrote:
> > The below code works for us.  Note that I did not implement the
> > node-interleaving parts of the AMD algorithm.  If that matters, it should
> > be simple enough to do.  The BKDG has good pseudo-code.  The only thing it
> > gets absolutely wrong is the IO hole.
> 
> Thanks. But without a per board DIMM mapping it's pretty useless, isn't it?

Exactly.

> One could detect the IO hole by reading the IORR MSRs or alternatively
> parsing the e820 map in /var/log/boot.msg

Why bother?  In this process - turning a physical address into a DIMM,
you're poking at all the data anyway, just get the IO hole straight from
the chipset.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVCaLNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVCaLNL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVCaLNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:13:11 -0500
Received: from ns1.suse.de ([195.135.220.2]:27042 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261331AbVCaLMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:12:36 -0500
Date: Thu, 31 Mar 2005 13:12:35 +0200
From: Andi Kleen <ak@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andi Kleen <ak@suse.de>, blaisorblade@yahoo.it, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] x86_64: remove duplicated sys_time64
Message-ID: <20050331111235.GL1623@wotan.suse.de>
References: <20050330173216.426CFEFECF@zion> <20050331103834.GC1623@wotan.suse.de> <20050331211059.0ddc078c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331211059.0ddc078c.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 09:10:59PM +1000, Stephen Rothwell wrote:
> On Thu, 31 Mar 2005 12:38:34 +0200 Andi Kleen <ak@suse.de> wrote:
> >
> > Nack. The generic sys_time still writes to int, not long.
> > That is why x86-64 has a private one. Please keep that.
> 
> It writes to a time_t which is a __kernel_time_t which is a long on
> x86-64, isn't it?

At least in 2.6.10 it writes to int.


-Andi

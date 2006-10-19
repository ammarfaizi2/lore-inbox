Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423082AbWJSRbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423082AbWJSRbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423083AbWJSRbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:31:14 -0400
Received: from solarneutrino.net ([66.199.224.43]:4367 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1423082AbWJSRbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:31:13 -0400
Date: Thu, 19 Oct 2006 13:31:08 -0400
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Keith Packard <keithp@keithp.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
Message-ID: <20061019173108.GA28700@tau.solarneutrino.net>
References: <20061013194516.GB19283@tau.solarneutrino.net> <1160849723.3943.41.camel@neko.keithp.com> <20061017174020.GA24789@tau.solarneutrino.net> <1161124062.25439.8.camel@neko.keithp.com> <4535CFB1.2010403@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4535CFB1.2010403@tungstengraphics.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 07:54:41AM +0100, Keith Whitwell wrote:
> This is all a little confusing as the driver doesn't really use that 
> path in normal operation except for a single command - MI_FLUSH, which 
> is shared between the architectures.  In normal operation the hardware 
> does the validation for us for the bulk of the command stream.  If there 
>  were missing functionality in that ioctl, it would be failing 
> everywhere, not just in this one case.
> 
> I guess the questions I'd have are
> 	- did the driver work before the kernel upgrade?
> 	- what path in userspace is seeing you end up in this ioctl?
> 	- and like Keith, what commands are you seeing?
> 
> The final question is interesting not because we want to extend the 
> ioctl to cover those, but because it will give a clue how you ended up 
> there in the first place.

Here's a list of all the failing commands I've seen so far:

3a440003
d70003
2d010003
e5b90003
2e730003
8d8c0003
c10003
d90003
be0003
1e3f0003

-ryan

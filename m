Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUFNXod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUFNXod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 19:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUFNXod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 19:44:33 -0400
Received: from colin2.muc.de ([193.149.48.15]:58632 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264579AbUFNXob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 19:44:31 -0400
Date: 15 Jun 2004 01:44:30 +0200
Date: Tue, 15 Jun 2004 01:44:30 +0200
From: Andi Kleen <ak@muc.de>
To: Paul Jackson <pj@sgi.com>
Cc: Andi Kleen <ak@muc.de>, anton@samba.org, linux-kernel@vger.kernel.org,
       lse-tech@projects.sourceforge.net
Subject: Re: NUMA API observations
Message-ID: <20040614234430.GB90963@colin2.muc.de>
References: <20040614153638.GB25389@krispykreme> <20040614161749.GA62265@colin2.muc.de> <20040614142128.4da12a8d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614142128.4da12a8d.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 02:21:28PM -0700, Paul Jackson wrote:
> Andi wrote:
> > How should a user space application sanely discover the cpumask_t
> > size needed by the kernel?  Whoever designed that was on crack.
> > 
> > I will probably make it loop and double the buffer until EINVAL
> > ends or it passes a page and add a nasty comment.
> 
> I agree that a loop is needed.  And yes someone didn't do a very
> good job of designing this interface.

I add some code to go upto a page now.

This adds a hardcoded limit of 32768 CPUs to libnuma. That's not 
nice, but we have to stop somewhere in case the EINVAL is returned
for other reason
(I really dislike this error code btw, it is near always far too 
ambigious...)


> 
> I posted a piece of code that gets a usable upper bound on cpumask_t
> size, suitable for application code to size mask buffers to be used
> in these system calls.

My code works basically the same, but thanks for the pointer.

-Andi

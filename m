Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVAYAEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVAYAEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVAYAC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:02:27 -0500
Received: from mta02.pge.com ([131.89.129.72]:34035 "EHLO mta02.pge.com")
	by vger.kernel.org with ESMTP id S261606AbVAYABH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:01:07 -0500
Date: Mon, 24 Jan 2005 15:53:11 -0800
From: Edward Peschko <esp5@pge.com>
To: Richard Henderson <rth@redhat.com>
Cc: gcc@gcc.gnu.org, libc-alpha@sources.redhat.com,
       binutils@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: forestalling GNU incompatibility - proposal for binary relative dynamic linking
Message-ID: <20050124235311.GD19422@venus>
References: <20050124222449.GB16078@venus> <20050124231047.GC29545@redhat.com> <20050124231636.GC19422@venus> <20050124233849.GA29765@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124233849.GA29765@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 03:38:49PM -0800, Richard Henderson wrote:
> On Mon, Jan 24, 2005 at 03:16:36PM -0800, Edward Peschko wrote:
> > cool.. any chance for some syntactic sugar so me (and other 
> > users/vendors) wouldn't need to change any of their build scripts 
> > and compilation processes?
> 
> Uh, like what?  That's about as simple as you can get.
> 
> 
> r~

I don't understand. 

Which is simpler, changing an environmental variable, or adding extra 
CFLAGS to every single compile and recompiling?

In addition, in your --rpath example, the relative pathing is hardcoded
into the executable, wheras with "*" you could modify the runtime behavior
of the executable at runtime. I suppose you could change this with chrpath,
but why bother? What if you want to test out two versions of relative
libraries side by side? 

And in any case, I'm not even sure if you can change the runtime path 
to something longer than what currently exists in the executable using
chrunpath.


And finally, certain programs (glibc, for example) seem to get into to 
trouble (ie: not compile) when you use --rpath flags. So, what's the 
issue with "*"?

Ed

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVAYAeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVAYAeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVAYAdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:33:04 -0500
Received: from nevyn.them.org ([66.93.172.17]:40357 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261725AbVAYA3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:29:55 -0500
Date: Mon, 24 Jan 2005 19:29:39 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Edward Peschko <esp5@pge.com>
Cc: Richard Henderson <rth@redhat.com>, gcc@gcc.gnu.org,
       libc-alpha@sources.redhat.com, binutils@sources.redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: forestalling GNU incompatibility - proposal for binary relative dynamic linking
Message-ID: <20050125002939.GA12826@nevyn.them.org>
Mail-Followup-To: Edward Peschko <esp5@pge.com>,
	Richard Henderson <rth@redhat.com>, gcc@gcc.gnu.org,
	libc-alpha@sources.redhat.com, binutils@sources.redhat.com,
	linux-kernel@vger.kernel.org
References: <20050124222449.GB16078@venus> <20050124231047.GC29545@redhat.com> <20050124231636.GC19422@venus> <20050124233849.GA29765@redhat.com> <20050124235311.GD19422@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124235311.GD19422@venus>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 03:53:11PM -0800, Edward Peschko wrote:
> On Mon, Jan 24, 2005 at 03:38:49PM -0800, Richard Henderson wrote:
> > On Mon, Jan 24, 2005 at 03:16:36PM -0800, Edward Peschko wrote:
> > > cool.. any chance for some syntactic sugar so me (and other 
> > > users/vendors) wouldn't need to change any of their build scripts 
> > > and compilation processes?
> > 
> > Uh, like what?  That's about as simple as you can get.
> > 
> > 
> > r~
> 
> I don't understand. 
> 
> Which is simpler, changing an environmental variable, or adding extra 
> CFLAGS to every single compile and recompiling?
> 
> In addition, in your --rpath example, the relative pathing is hardcoded
> into the executable, wheras with "*" you could modify the runtime behavior
> of the executable at runtime. I suppose you could change this with chrpath,
> but why bother? What if you want to test out two versions of relative
> libraries side by side? 

You might want to take a look at Richard's suggestion again.  The
string '$ORIGIN' gets hardcoded into the binary and handled by the
dynamic linker.

But really, RPATH is a good solution to almost no problems.

-- 
Daniel Jacobowitz

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbTIDMVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbTIDMVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:21:44 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:63625 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264938AbTIDMVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:21:42 -0400
Date: Thu, 4 Sep 2003 13:20:29 +0100
From: Dave Jones <davej@redhat.com>
To: Rusty Trivial Russell <trivial@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] [resend patch] CONFIG_X86_GENERIC description fixup
Message-ID: <20030904122029.GA3357@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rusty Trivial Russell <trivial@rustcorp.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030904033019.794AD2C0B1@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904033019.794AD2C0B1@lists.samba.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:26:41PM +1000, Rusty Trivial Russell wrote:
 
 >   as per thread on lkml a little while ago, a better explanation
 >   of the X86_GENERIC config option follows. The person who questioned
 >   it originally seemed to like this improved version, so that's one point :)

How about explaining _exactly_ what it does? This is still a somewhat
mysterious description. "generic optimisations" what is that ?

 > --- trivial-2.6.0-test4-bk5/arch/i386/Kconfig.orig	2003-09-04 13:02:02.000000000 +1000
 > +++ trivial-2.6.0-test4-bk5/arch/i386/Kconfig	2003-09-04 13:02:02.000000000 +1000
 > @@ -303,9 +303,13 @@
 >  config X86_GENERIC
 >         bool "Generic x86 support" 
 >         help
 > -       	  Including some tuning for non selected x86 CPUs too.
 > -	  when it has moderate overhead. This is intended for generic 
 > -	  distributions kernels.
 > +	  Instead of just including optimizations for the selected
 > +	  x86 variant (e.g. PII, Crusoe or Athlon), include some more
 > +	  generic optimizations as well. This will make the kernel
 > +	  perform better on x86 CPUs other than that selected.
 > +
 > +	  This is really intended for distributors who need more
 > +	  generic optimizations.

All that it seems to do right now is set the cacheline size to the
same as it would if the kernel was compiled for P4, regardless of
what target CPU is selected, so that for eg, an i686 kernel won't
perform any worse on a P4, saving vendors shipping seperate P4 kernels.
it should also note what performance impact (if any) users of this
option will see if they run such a kernel on a box with a smaller
cacheline size.

If this option ever does anything else, that too should get documented here.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271205AbUJVD0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271205AbUJVD0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271060AbUJVDJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:09:40 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:30900 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S271030AbUJVCy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:54:28 -0400
Date: Fri, 22 Oct 2004 04:54:27 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module compilation
Message-ID: <20041022025427.GA3440@mail.13thfloor.at>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com> <20041021201545.GA16474@mars.ravnborg.org> <Pine.LNX.4.61.0410211415560.14971@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410211415560.14971@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 02:21:25PM -0400, Richard B. Johnson wrote:
> On Thu, 21 Oct 2004, Sam Ravnborg wrote:
> 
> >On Wed, Oct 20, 2004 at 10:36:00AM -0400, Richard B. Johnson wrote>
> >>...but it's not CFLAGS that needs to be modified, it's
> >>a named variable that doesn't exist yet, perhaps "USERDEF",
> >>or "DEFINES".
> >
> >Reading the above I cannot what amkes you say that EXTRA_CFLAGS
> >or CFLAGS_module.o cannot be used?
> >Is it the name you do not like or is it some fnctionality
> >you are missing?
> >
> 
> The name is wrong! There are zillions of ways to obtain the
> functionality. Currently we need to piggy-back definitions
> onto compiler flags.
> 
> Compiler flags are things like "-Wall" and "-O2", that tell
> the compiler what to do. We need a name to use for definitions,
> "-Dxxx", that #define constants (dynamically at compile-time)
> in the code. Right now, -DMODULE and -D__KERNEL__ are piggybacked
> onto CFLAGS. There really should be a variable called something
> else like DEFINES and it should be exported.

hmm, the man page for gcc states that

 -Dmacro 	is a preprocessor option, where
 -Wall 		is a compiler option, and
 -O2 		is an optimization option

but, all of those are options to the cpp/gcc
toolchain (or gcc compiler if you like), so
it sounds natural to me to put it there ...
(i.e. CFLAGS*)

best,
Herbert

> >>I see that the normal "defines" is a constant
> >>called "CHECKFLAGS", so this isn't appropriate for user
> >>modification.
> >CHECKFLAGS is only used when you use "make C=1" - to pass options
> >to sparse.
> >
> >	Sam
> >
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
>                  98.36% of all statistics are fiction.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

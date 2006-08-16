Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWHPDYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWHPDYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 23:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWHPDYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 23:24:04 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:50400 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750880AbWHPDYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 23:24:01 -0400
Date: Tue, 15 Aug 2006 22:23:37 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: casey@schaufler-ca.com, serue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060816032337.GF15241@sergelap.austin.ibm.com>
References: <787b0d920608151943k3d39b5b4v26f85cfbc527514c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920608151943k3d39b5b4v26f85cfbc527514c@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Albert Cahalan (acahalan@gmail.com):
> Casey Schaufler writes:
> >--- "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> >>+    bprm->cap_effective = fscaps[0];
> >>+    bprm->cap_inheritable = fscaps[1];
> >>+    bprm->cap_permitted = fscaps[2];
> >
> >It does not appear that you're attempting
> >to maintain the POSIX exec semantics for
> >capability sets. (If you're doing it
> >elsewhere in the code, nevermind) I don't
> >know if this is intentional or not.
> 
> Stop right there. No such POSIX semantics exist.
> There is no POSIX standard for this. Out in the
> wild there are numerous dangerously incompatible
> ideas about this concept:
> 
> a. SGI IRIX, and one draft of a failed POSIX proposal
> b. Linux (half done), and a very different draft
> c. DG-UX, which actually had a workable system
> d. Solaris, which is workable and getting used
> 
> My rant from 4 years ago mostly applies today.
> http://lkml.org/lkml/2003/10/22/135
> 
> (yes, we have a lame SGI-style set of bits with
> a set of equations that is not compatible)
> 
> Something has changed though: people are actually
> using this type of thing on Solaris. Probably the
> sanest thing to do is to copy Solaris: equations,
> tools, set of bits, #define names, API, etc. Just
> let Sun be the standard, and semi-portable apps
> will be able to use the feature. Cross-platform
> admins will be very grateful for the consistency.

Does anyone have a security/solaris_prm.ko module they've
been quietly working on or using?

(given the number of fscaps patches out there, it seems a
reasonable question)

thanks,
-serge

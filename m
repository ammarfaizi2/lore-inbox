Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267682AbUHZFWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267682AbUHZFWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 01:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUHZFVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 01:21:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:63462 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267664AbUHZFUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 01:20:39 -0400
Date: Wed, 25 Aug 2004 22:18:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, erikj@dbear.engr.sgi.com, limin@engr.sgi.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] new CSA patchset for 2.6.8
Message-Id: <20040825221842.72dd83a4.akpm@osdl.org>
In-Reply-To: <412D2E10.8010406@engr.sgi.com>
References: <412D2E10.8010406@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan <jlan@engr.sgi.com> wrote:
>
> I have broken up one big CSA kernel patch into four smaller ones
>  as attached:
> 
>       csa_io     - collects io accounting data
>       csa_mm     - collects mm accounting data
>       csa_eop    - provides a hook to perform end-of-process accounting
>       csa_module - builds csa loadable module

Please don't send patches as attachments, and please don't send more than
one patch per email.

If you stick to the one-patch-per-email rule, you also get an opportunity
to nicely describe each patch within its email.

Coding style nit:


	if (foo)
		bar();

is preferable to

	if (foo) {
		bar();
	}


More broadly: Help!

I am 100% not in a position to judge whether Linux needs Comprehensive
System Accounting, nor am I able to define what the requirements for such a
thing should be.  All I can tell from your patch is the quality of its
implementation, and that's leaping far, far ahead of where we should be.

We're going to need help from you, and from all the other stakeholders in
judging how useful this feature is to Linux implementors and how well this
implementation meets the (unknown) requirements.  See my problem?

I've cc'ed lse-tech, where enterprise folks hang out.  I would request that
the people who are stakeholders in this feature

a) stick their hands up

b) let us know how important this kind of feature is for their users

c) review the offered feature set against their requirements

d) let us know how well the implementation fits that requirement and

e) inform us of any competing implementations.  Compare and contrast.

Thanks.


> There are no functional changes in this set of csa patches compared
> to the 2.6.7 patch linux-2.6.7.csa.patch.
> 
> Patches csa_io, csa_mm, and csa_eop are independent of each other.  You may
> apply any one, any two or all three and you will be able to build a
> functional kernel.  However, data collected needs an agent to use it.  The
> csa_module is one agent that takes advangtage of the feature and it works
> with csa-2.0.0 (or later) to report system accounting data of the host
> system.  The csa-2.0.0 rpm can be downloaded from
> ftp://oss.sgi.com/projects/csa/download
> 
> The csa_module patch requires all three accounting data patches to be fully
> functional.
> 
> This set of csa patches has been tested with the pagg and job kernel
> patches to linux 2.6.8 kernel.  The information of pagg and job project can
> be found at http://oss.sgi.com/projects/pagg/
> 
> The csa_module requires the pagg and job kernel patches.
> 
> Feedback, bug reports, and comments are very welcome!
> 

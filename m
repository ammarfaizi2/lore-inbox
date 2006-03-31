Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWCaFuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWCaFuv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 00:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWCaFuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 00:50:50 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:11139 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750873AbWCaFuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 00:50:50 -0500
Date: Thu, 30 Mar 2006 21:51:59 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chris Wright <chrisw@sous-sol.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       David Lang <dlang@digitalinsight.com>, Sam Vilain <sam@vilain.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060331055159.GG15997@sorel.sous-sol.org>
References: <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org> <Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz> <20060330020445.GT15997@sorel.sous-sol.org> <20060330143224.GC6933@sergelap.austin.ibm.com> <m1bqvndb7t.fsf@ebiederm.dsl.xmission.com> <20060330190758.GY15997@sorel.sous-sol.org> <m1lkurb2gs.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1lkurb2gs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman (ebiederm@xmission.com) wrote:
> Very simple, it should be possible statically compile in
> all of the security modules and be able to pick at run time which
> security module to use.
> 
> Unless I have been very blind and missed something skimming
> through the code compiling if I compile in all of the security
> modules, whichever one is initialized first is the one
> that we will use.

I see.  No, you got that correct.  That's rather intentional, to make
sure all objects are properly initialized as they are allocated rather
than having to double check at every access control check.  That's why
security_initcalls are so early.

thanks,
-chris

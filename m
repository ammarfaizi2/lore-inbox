Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWCaGx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWCaGx4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWCaGx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:53:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42429 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751177AbWCaGxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:53:55 -0500
To: Chris Wright <chrisw@sous-sol.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       David Lang <dlang@digitalinsight.com>, Sam Vilain <sam@vilain.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <442B0BFE.9080709@vilain.net>
	<20060329225241.GO15997@sorel.sous-sol.org>
	<m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
	<20060330013618.GS15997@sorel.sous-sol.org>
	<Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz>
	<20060330020445.GT15997@sorel.sous-sol.org>
	<20060330143224.GC6933@sergelap.austin.ibm.com>
	<m1bqvndb7t.fsf@ebiederm.dsl.xmission.com>
	<20060330190758.GY15997@sorel.sous-sol.org>
	<m1lkurb2gs.fsf@ebiederm.dsl.xmission.com>
	<20060331055159.GG15997@sorel.sous-sol.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 30 Mar 2006 23:52:00 -0700
In-Reply-To: <20060331055159.GG15997@sorel.sous-sol.org> (Chris Wright's
 message of "Thu, 30 Mar 2006 21:51:59 -0800")
Message-ID: <m1zmj79kdr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> writes:

> * Eric W. Biederman (ebiederm@xmission.com) wrote:
>> Very simple, it should be possible statically compile in
>> all of the security modules and be able to pick at run time which
>> security module to use.
>> 
>> Unless I have been very blind and missed something skimming
>> through the code compiling if I compile in all of the security
>> modules, whichever one is initialized first is the one
>> that we will use.
>
> I see.  No, you got that correct.  That's rather intentional, to make
> sure all objects are properly initialized as they are allocated rather
> than having to double check at every access control check.  That's why
> security_initcalls are so early.

Ok.  That make sense.  The fact that some of the security modules
besides selinux are tristate in Kconfig had me confused for a moment.

Controlling what to run with a kernel command line makes sense
then.

Having a generic command line like lsm=[selinux|root_plug|capability|seclvl]
would be nice.  Where nothing supplied would not enable any of
the linux security modules.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWCaFjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWCaFjD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 00:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWCaFjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 00:39:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51388 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750778AbWCaFjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 00:39:02 -0500
To: Chris Wright <chrisw@sous-sol.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       David Lang <dlang@digitalinsight.com>, Sam Vilain <sam@vilain.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <442A26E9.20608@vilain.net>
	<20060329182027.GB14724@sorel.sous-sol.org>
	<442B0BFE.9080709@vilain.net>
	<20060329225241.GO15997@sorel.sous-sol.org>
	<m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
	<20060330013618.GS15997@sorel.sous-sol.org>
	<Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz>
	<20060330020445.GT15997@sorel.sous-sol.org>
	<20060330143224.GC6933@sergelap.austin.ibm.com>
	<m1bqvndb7t.fsf@ebiederm.dsl.xmission.com>
	<20060330190758.GY15997@sorel.sous-sol.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 30 Mar 2006 22:36:03 -0700
In-Reply-To: <20060330190758.GY15997@sorel.sous-sol.org> (Chris Wright's
 message of "Thu, 30 Mar 2006 11:07:58 -0800")
Message-ID: <m1lkurb2gs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> writes:

>> With appropriate care we should be able to allow the container
>> administrator to use this capability to select which security
>> policies, and mechanisms they want. 
>> 
>> That is something we probably want to consider anyway as
>> currently the security modules break the basic rule that
>> compiling code in should not affect how the kernel operates
>> by default.
>
> Don't follow you on this one.

Very simple, it should be possible statically compile in
all of the security modules and be able to pick at run time which
security module to use.

Unless I have been very blind and missed something skimming
through the code compiling if I compile in all of the security
modules, whichever one is initialized first is the one
that we will use.

Eric

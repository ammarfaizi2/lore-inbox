Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424314AbWKJFVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424314AbWKJFVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 00:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424356AbWKJFVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 00:21:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24769 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1424314AbWKJFVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 00:21:38 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Undeprecate sys_sysctl
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
	<200611092317.26459.s0348365@sms.ed.ac.uk>
Date: Thu, 09 Nov 2006 22:21:13 -0700
In-Reply-To: <200611092317.26459.s0348365@sms.ed.ac.uk> (Alistair John
	Strachan's message of "Thu, 9 Nov 2006 23:17:26 +0000")
Message-ID: <m1ejsbnagm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:

> On Wednesday 08 November 2006 19:00, you wrote:
>> The basic issue is that despite have been deprecated and warned about
>> as a very bad thing in the man pages since its inception there are a
>> few real users of sys_sysctl.  It was my assumption that because
>> sysctl had been deprecated for all of 2.6 there would be no user space
>> users by this point, so I initially gave sys_sysctl a very short
>> deprecation period.
>>
>> Now that I know there are a few real users the only sane way to
>> proceed with deprecation is to push the time limit out to a year or
>> two work and work with distributions that have big testing pools like
>> fedora core to find these last remaining users.
>
> Eric, do you have a list of the remaining users? It'd be good to know for 
> people using Linux in an embedded environment, where they may want to switch 
> off the option, but only if it doesn't break their userspace.

They are very very few.  The ones I recall are kudzu, radvd, and
libpthreads (which doesn't care).  

There is a thread a month or so ago about this where I did a request
for testers, that listed all of the users we could find.

The reality is that I don't think kernel developers can seriously find
them.

If someone actually wants to kill sys_sysctl more power to them.  As
long as we don't add more binary numbers I think it is actually easier
to support it than to find those weird users and remove it.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947101AbWKKF2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947101AbWKKF2V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 00:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947102AbWKKF2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 00:28:21 -0500
Received: from terminus.zytor.com ([192.83.249.54]:436 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1947101AbWKKF2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 00:28:20 -0500
Message-ID: <45555F4F.8060600@zytor.com>
Date: Fri, 10 Nov 2006 21:27:43 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, alan@redhat.com,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jakub Jelinek <jakub@redhat.com>, Mike Galbraith <efault@gmx.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Bill Nottingham <notting@redhat.com>,
       Marco Roeland <marco.roeland@xs4all.nl>,
       Michael Kerrisk <mtk-manpages@gmx.net>
Subject: Re: [PATCH] sysctl:  Undeprecate sys_sysctl (take 2)
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>	<9a8748490611081110m4cc62c1bp3a36aba3fc314e56@mail.gmail.com>	<m1ejsd3e38.fsf_-_@ebiederm.dsl.xmission.com>	<200611100750.10990.ak@suse.de> <m1u017lpzd.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1u017lpzd.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
>> On Wednesday 08 November 2006 20:58, Eric W. Biederman wrote:
>>> The basic issue is that despite have been ``deprecated'' and
>>> warned about as a very bad thing in the man pages since it's
>>> inception there are a few real users of sys_sysctl. 
>> But they only seem to use a small number of actually used with
>> sysctl(2) sysctls.
>> I still think just maintaining a conversion table for 
>> those is the right thing to do.
> 
> I don't know.  Every distinct user of the binary sysctl interface
> used a different entry.  So the fact that there are a small number of
> programs and thus a small number of sysctls used I agree with.  I do
> not agree with the conclusion that we can predict the set of binary
> sysctl that are in use.  We do not get good enough feedback from
> the user community.
> 
> I don't have a problem with the principle of a conversion table
> if it meant that we would never add any additional binary sysctls.
>

Okay, my opinion now...

I think we should change the sysctl system so most sysctls simply aren't 
accessible through the binary interface.  The rest of them should be 
documented in one place, preferrably machine-readable.

However, I think having the binary sysctls available as a limited last 
resort is better than adding ad hoc system calls all over the place, 
like sys_mips.

	-hpa


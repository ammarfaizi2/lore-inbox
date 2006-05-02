Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWEBODE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWEBODE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWEBODE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:03:04 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:53773 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S964833AbWEBODD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:03:03 -0400
Message-ID: <4457668F.8080605@argo.co.il>
Date: Tue, 02 May 2006 17:02:55 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <20060502133416.GT27946@ftp.linux.org.uk>
In-Reply-To: <20060502133416.GT27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 14:03:01.0039 (UTC) FILETIME=[1F8B0BF0:01C66DF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Tue, May 02, 2006 at 01:32:05PM +0300, Avi Kivity wrote:
>   
>> Like the recent prevent_tail_call() thing? Granted, C++ is a lot tricker 
>> than C. Much self-restraint is needed, and even then you can wind up 
>> where you didn't want to go.
>>     
>
> 	Sigh...  You know, once upon a time there was a language called
> Algol 68.  It had a _lot_ of expressive power and was fairly flexible -
> both in type system and in syntax.  And it had been a fscking nightmare
> for large projects.  Not because of lack of modularity - that part had
> been all right.  The thing that kept killing large projects was different;
> in effect, each group ended up with a language subset and developed a
> discipline for it.  And as soon as they mixed, _especially_ if they were
> close, but not quite the same, you had an ever-growing disaster.
>
> 	It's not easy to quantify; each language has dark corners and
> there are more or less odd constructs specific to individual programmers
> and to groups.  And yes, you certainly can write unreadable crap in any
> language.  The question is, how many variants of "needed self-restraint"
> are widespread, how well do they mix and how easy it is to recognize the
> mismatches?  It's not a function of language per se, so it doesn't make
> sense to compare C and C++ as languages in that respect.  However, C++
> and C _styles_ can be compared and that's where C++ requires more force
> to keep a large project away from becoming a clusterfsck.
>
> 	Sure, you need make sure that different groups of people use
> more or less compatible styles anyway; it's just that with C++ you need
> tighter control to get the same result.  And for kernel it's a killer.
>   

Hey, I agree 100%, except for the last 6 words :) C++ is the very worst 
language I know in terms of badly thought out features, internal 
inconsistencies, ways to shoot one's feet off, and general ugliness. It 
will require _very_ tight control to avoid parts of the kernel going off 
in mutually incompatible directions.

But I think that the control is there; and if C++ is introduced slowly, 
one feature at a time, it can be kept sane. And I think there is 
definitely a payoff to be won out of a switch.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWBGWns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWBGWns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWBGWnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:43:43 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:61341 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1030216AbWBGWnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:43:22 -0500
Message-ID: <43E9227C.70200@vilain.net>
Date: Wed, 08 Feb 2006 11:43:08 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>	<43E83E8A.1040704@vilain.net> <m1oe1jfa5n.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1oe1jfa5n.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote [note: quoting sections out of order]:
> Sam Vilain <sam@vilain.net> writes:
>>Let's compare approaches of patchsets before the patchsets themselves.
>>It seems to be, should we:
>>   A) make a general form of virtualising PIDs, and hope this assists
>>      later virtualisation efforts (Eric's patch)
>>I can't think of any real use cases where you would specifically want A)
>>without B).
> You misrepresent my approach.  

ok, after reading more of your post, agreed.

 > What user interface to export is a debate worth having.

This is the bit that needs a long period of prototyping and experimental
use IMHO.  So in essence, we're agreeing on that point.

> First there is a huge commonality in the code bases between the
> different implementations and I have already gotten preliminary
> acceptance from the vserver developers, that my approach is sane.  The
> major difference is what user interface does the kernel export,
> and I posted my user interface.
 > Second I am not trying to just implement a form of virtualizing PIDs.
 > Heck I don't intend to virtualize anything.  The kernel has already
 > virtualized everything I require.  I want to implement multiple
 > instances of the current kernel global namespaces.  All I want is
 > to be able to use the same name twice in user space and not have
 > a conflict.

Right, well, I think our approaches might have more in common than
I previously thought.

Indeed, it seems that at least one of the features of Linux-VServer I am
preparing for consideration for inclusion into Linus' tree are your work
:-).

> Beyond getting multiple instance of all of the kernel namespaces
> (which is the hard requirement for migration) my approach is to
> see what is needed for projects like vserver and vps and see how
> their needs can be met as well. 

ok, but the question is - doesn't this just constitute a refactoring 
once the stable virtualisation code is in?

I'm just a bit nervous about trying to 
refactor-approach-and-concepts-as-we-go.

But look, I'll take a closer look at your patches, and see if I can 
merge with you anyhow.  Thanks for the git repo!

Sam.

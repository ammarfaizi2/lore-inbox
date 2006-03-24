Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWCXT4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWCXT4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWCXT4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:56:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52184 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750790AbWCXT4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:56:14 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>
	<1143228339.19152.91.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Mar 2006 12:53:55 -0700
In-Reply-To: <1143228339.19152.91.camel@localhost.localdomain> (Dave
 Hansen's message of "Fri, 24 Mar 2006 11:25:39 -0800")
Message-ID: <m18xqzippo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Sat, 2006-03-25 at 04:33 +1100, Nick Piggin wrote:
>> Oh, after you come to an agreement and start posting patches, can you
>> also outline why we want this in the kernel (what it does that low
>> level virtualization doesn't, etc, etc) 
>
> Can you wait for an OLS paper? ;)
>
> I'll summarize it this way: low-level virtualization uses resource
> inefficiently.
>
> With this higher-level stuff, you get to share all of the Linux caching,
> and can do things like sharing libraries pretty naturally.

Also it is a major enabler for things such as process migration,
between kernels.

> They are also much lighter-weight to create and destroy than full
> virtual machines.  We were planning on doing some performance
> comparisons versus some hypervisors like Xen and the ppc64 one to show
> scaling with the number of virtualized instances.  Creating 100 of these
> Linux containers is as easy as a couple of shell scripts, but we still
> can't find anybody crazy enough to go create 100 Xen VMs.

One of my favorite test cases is to kill about 100 of them
simultaneously :)

I think on a reasonably beefy dual processor machine I should be able
to get about 1000 of them running all at once.

> Anyway, those are the things that came to my mind first.  I'm sure the
> others involved have their own motivations.

The practical aspect is that several groups have found the arguments
compelling enough that they have already done complete
implementations.  At which point getting us all to agree on a common
implementation is important. :)

Eric

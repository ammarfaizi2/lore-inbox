Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWC1PGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWC1PGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWC1PGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:06:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39322 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750732AbWC1PGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:06:34 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>
	<1143228339.19152.91.camel@localhost.localdomain>
	<4428BB5C.3060803@tmr.com> <4428FB2B.8070805@sw.ru>
	<44294B33.3040507@tmr.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Mar 2006 08:03:34 -0700
In-Reply-To: <44294B33.3040507@tmr.com> (Bill Davidsen's message of "Tue, 28
 Mar 2006 09:41:55 -0500")
Message-ID: <m1d5g6d321.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> Kirill Korotaev wrote:
>
>>> Frankly I don't see running 100 VMs as a realistic goal, being able to run
>>> Linux, Windows, Solaris and BEOS unmodified in 4-5 VMs would be far more
>>> useful.
>>
>> It is more than realistic. Hosting companies run more than 100 VPSs in
>> reality. There are also other usefull scenarios. For example, I know the
>> universities which run VPS for every faculty web site, for every department,
>> mail server and so on. Why do you think they want to run only 5VMs on one
>> machine? Much more!
>
> I made no commont on what "they" might want, I want to make the rack of
> underutilized Windows, BSD and Solaris servers go away. An approach which
> doesn't support unmodified guest installs doesn't solve any of my current
> problems. I didn't say it was in any way not useful, just not of interest to
> me. What needs I have for Linux environments are answered by jails and/or UML.

So from one perspective that is what we are building.  A full featured
jail capable of running an unmodified linux distro.  The cost is
simply making a way to use the same names twice for the global
namespaces.  UML may use these features to accelerate it's own processes.

Virtualization is really the wrong word to describe what we are building.  As
it allows for all kinds of heavy weight implementations, and has an associate
with much heavier things.  

At the extreme end where you only have one process in each logical instance
of the kernel, a better name would be a heavy weight process.  Where each
such process sees an environment as if it owned the entire machine.

Eric

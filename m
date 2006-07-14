Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422720AbWGNTNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbWGNTNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWGNTNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:13:13 -0400
Received: from terminus.zytor.com ([192.83.249.54]:36064 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1422715AbWGNTNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:13:12 -0400
Message-ID: <44B7EC64.5070907@zytor.com>
Date: Fri, 14 Jul 2006 12:11:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>	 <44B54EA4.5060506@redhat.com> <20060712195349.GW3823@sunsite.mff.cuni.cz>	 <44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>	 <1152739766.3217.83.camel@laptopd505.fenrus.org>	 <m1bqru8p36.fsf@ebiederm.dsl.xmission.com>	 <1152741665.3217.85.camel@laptopd505.fenrus.org>	 <44B57191.5000802@zytor.com>  <m1zmfe794e.fsf@ebiederm.dsl.xmission.com>	 <1152745664.22943.115.camel@localhost.localdomain> <1152902745.23037.88.camel@localhost.localdomain>
In-Reply-To: <1152902745.23037.88.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>
>> If you want to do the job right then do this
>>
>> - Stick an indicator of how much else wants to run on this CPU in the
>> vsyscall page or similar location
> 
> Except that "this cpu" doesn't really mean anything in userspace, and
> while I think Andi has some tricks to get some sort of CPU number to
> userspace (though it's really only valid during the execution of the
> instruction that reads it :) I haven't yet found an equivalent for
> powerpc (and possibly other architectures will have the same problem).
> 

Sure it does... although its validity in terms of a locality metric 
decays with time.

	-hpa

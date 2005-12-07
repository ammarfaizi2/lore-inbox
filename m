Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbVLGTn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVLGTn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVLGTn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:43:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36037 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030324AbVLGTn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:43:28 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>
	<m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	<1133977623.24344.31.camel@localhost>
	<1133978128.2869.51.camel@laptopd505.fenrus.org>
	<1133978996.24344.42.camel@localhost>
	<1133982048.2869.60.camel@laptopd505.fenrus.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 07 Dec 2005 12:42:06 -0700
In-Reply-To: <1133982048.2869.60.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Wed, 07 Dec 2005 20:00:48 +0100")
Message-ID: <m1d5k8d78x.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:
>> So, like in the global pidspace (which can see all pids and appears to
>> applications to be just like normal) you end up returning "kernel" pids
>> to userspace.  That didn't seem to make sense.  
>
> hmm this is scary. If you don't have "unique" pids inside the kernel a
> lot of stuff will subtly break. DRM for example (which has the pid
> inside locking to track ownership and recursion), but I'm sure there's
> many many cases like that. I guess the address of the task struct is the
> ultimate unique pid in this sense.... but I suspect the way to get there
> is first make a ->user_pid field, and switch all userspace visible stuff
> to that, and then try to get rid of ->pid users one by one by
> eliminating their uses... 
>
> but I'm really afraid that if you make the "fake" pid visible to normal
> kernel code, too much stuff will go bonkers and end up with an eternal
> stream of security hazards. "Magic" hurts here, and if you don't do
> magic I don't see a reason to add an abstraction which in itself doesn't
> mean anything or doesn't abstract anything....

Thanks, you said that better that I did :)

Eric

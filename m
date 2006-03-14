Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWCNUW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWCNUW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCNUW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:22:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53961 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751502AbWCNUW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:22:56 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>,
       "Dave Hansen <haveblue@us.ibm.com> Cedric Le Goater" <clg@fr.ibm.com>,
       Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org
Subject: Re: question: pid space semantics.
References: <1142282940.27590.17.camel@localhost.localdomain>
	<m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
	<1142363896.28604.43.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 14 Mar 2006 13:21:25 -0700
In-Reply-To: <1142363896.28604.43.camel@localhost.localdomain> (Dave
 Hansen's message of "Tue, 14 Mar 2006 11:18:16 -0800")
Message-ID: <m1ek14lquy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Tue, 2006-03-14 at 11:43 -0700, Eric W. Biederman wrote:
>> The question:
>>   If we could add additional pid values in different pid spaces to a
>>   process with a syscall upon demand would that lead to an
>>   implementation everyone could use? 
>
> So, you'd basically only allocate the cross-namespace pids when you
> needed to do some kind of cross-namespace management?

Yes, or setup a parent/child relationship.  So I think the first
process in a container would always get two pids.

> pid_t alloc_local_pid(container_handle, pid_t pid_inside_container)

That is the idea.

I actually expect the implementation to look very much different.
To me the nice piece of this concept is that it allows all pids
to local to a pid space while still be able to talk to remote
processes.

Eric


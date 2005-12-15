Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVLOWfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVLOWfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVLOWfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:35:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5580 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751162AbVLOWft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:35:49 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: JANAK DESAI <janak@us.ibm.com>, viro@ftp.linux.org.uk, chrisw@osdl.org,
       dwmw2@infradead.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler
 function
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com>
	<m1k6e687e2.fsf@ebiederm.dsl.xmission.com>
	<43A1D435.5060602@us.ibm.com>
	<m1d5jy83nr.fsf@ebiederm.dsl.xmission.com>
	<20051215213234.GB6990@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 15 Dec 2005 15:34:06 -0700
In-Reply-To: <20051215213234.GB6990@mail.shareable.org> (Jamie Lokier's
 message of "Thu, 15 Dec 2005 21:32:34 +0000")
Message-ID: <m18xum7zxd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

>
>> Part of the problem is the double negative in the name, leading
>> me to suggest that sys_share might almost be a better name.
>
> I agree with that suggestion, too.
>
> Alternatively, we could just add a flag to clone(): CLONE_SELF,
> meaning don't create a new task, just modify the properties of the
> current task.

Internally I doubt it would make much difference.  There are
real differences from modifying current to copying from current.
Mostly it is ref counting but just enough that CLONE_SELF
is unlikely to be a sane thing to do.

Of course we could always implement spawn.  The syscall with
every possible option :)

Eric

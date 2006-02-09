Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbWBIDS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbWBIDS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 22:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbWBIDS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 22:18:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29860 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030528AbWBIDS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 22:18:58 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       riel@redhat.com, kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
	<m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com>
	<20060209021828.GC9456@ccure.user-mode-linux.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 20:16:38 -0700
In-Reply-To: <20060209021828.GC9456@ccure.user-mode-linux.org> (Jeff Dike's
 message of "Wed, 8 Feb 2006 21:18:28 -0500")
Message-ID: <m1ek2d43xl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> writes:

> On Wed, Feb 08, 2006 at 05:24:16PM -0700, Eric W. Biederman wrote:
>> To deal with networking there are currently a significant number of
>> variables with static storage duration.  Making those variables global
>> and placing them in structures is neither as efficient as it could be
>> nor is it as maintainable as it should be.  Other subsystems have
>> similar problems.
>
> BTW, there is another solution, which you may or may not consider to
> be clean.
>
> That is to load a separate copy of the subsystem (code and data) as a
> module when you want a new instance of it.  The code doesn't change,
> but you probably have to move it around some and provide some sort of
> interface to it.

There are some real drawbacks to that.  Basically as things are structured
you only want multiple copies of the user facing data structures.  Pretty
much everything else really does remain the same.

> I did this to the scheduler last year - see
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=111404726721747&w=2

I will take a look but I don't expect to find anything.

Eric


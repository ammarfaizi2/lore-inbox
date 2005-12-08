Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbVLHFiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVLHFiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 00:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbVLHFiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 00:38:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:44458 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965065AbVLHFiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 00:38:50 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>
	<m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	<1133977623.24344.31.camel@localhost>
	<m1hd9kd89y.fsf@ebiederm.dsl.xmission.com>
	<1133991650.30387.17.camel@localhost>
	<m18xuwd015.fsf@ebiederm.dsl.xmission.com>
	<1133994685.30387.47.camel@localhost>
From: Andi Kleen <ak@suse.de>
Date: 08 Dec 2005 03:09:11 -0700
In-Reply-To: <1133994685.30387.47.camel@localhost>
Message-ID: <p73bqzr6gu0.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:
> 
> Can you think of any?

qemu can afaik. I've also heard about simnow in qemu and 
Xen in qemu, although that's not true recursion.  And VMware/qemu/
simnow/UML/... will all probably run fine in Xen native guests.
I wouldn't be surprised if UML supported true recursion too.

But then for what do you really need recursion? It might be nice
theory, but in practice it's probably not too relevant.  I guess it
was useful long ago for debugging VM itself when mainframes were
really expensive so you couldn't just buy a development machine and
test your VM on raw iron. But that's not really true today anymore.

Ok one weak reason to still use it might be if your test machine takes
too long to reboot.  But then Hypervisor hackers are a pretty narrow
target group for features like this.

-Andi

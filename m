Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946259AbWJTNnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946259AbWJTNnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946261AbWJTNnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:43:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37782 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1946259AbWJTNnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:43:46 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       Cal Peake <cp@absolutedigital.net>
Subject: Re: [CFT] Grep to find users of sys_sysctl.
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
	<Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
	<20061018124415.e45ece22.akpm@osdl.org>
	<m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
	<m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
	<20061020080216.GH1785@devserv.devel.redhat.com>
Date: Fri, 20 Oct 2006 07:41:51 -0600
In-Reply-To: <20061020080216.GH1785@devserv.devel.redhat.com> (Jakub Jelinek's
	message of "Fri, 20 Oct 2006 04:02:16 -0400")
Message-ID: <m17iyv3y00.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:

> On Fri, Oct 20, 2006 at 01:05:18AM -0600, Eric W. Biederman wrote:
>> 
>> Anyone who is interested in knowing if they have an application on
>> their system that actually uses sys_sysctl please run the following grep.
>> 
>> find / -type f  -perm /111 -exec fgrep 'sysctl@@GLIBC' '{}' ';' 
>
> This assumes the binaries and/or libraries are not stripped, and they
> usually are stripped.  So, it is better to run something like:
> find / -type f -perm /111 | while read f; do readelf -Ws $f 2>/dev/null | fgrep
> -q sysctl@GLIBC && echo $f; done

Thanks the better grep helps.

Eric

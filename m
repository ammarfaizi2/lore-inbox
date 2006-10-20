Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422800AbWJTM4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWJTM4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423092AbWJTM4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:56:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44227 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422800AbWJTM4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:56:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
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
	<20061020003540.10d367d9.akpm@osdl.org>
Date: Fri, 20 Oct 2006 06:54:43 -0600
In-Reply-To: <20061020003540.10d367d9.akpm@osdl.org> (Andrew Morton's message
	of "Fri, 20 Oct 2006 00:35:40 -0700")
Message-ID: <m1bqo7406k.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Fri, 20 Oct 2006 01:05:18 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> 
>> Anyone who is interested in knowing if they have an application on
>> their system that actually uses sys_sysctl please run the following grep.
>> 
>> find / -type f  -perm /111 -exec fgrep 'sysctl@@GLIBC' '{}' ';' 
>> 
>> The -perm /111 is an optimization to only look at executable files,
>> and may be omitted if you are patient.
>> 
>> Currently I don't expect anyone to find a match anywhere except in
> libpthreads,
>> if you find any others please let me know.
>> 
>
> http://www.google.com/codesearch
>
> there are a few hits...

What were you using for search criteria?

A challenge is to weed out code that runs on BSDs where people do use sysctl.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbUK3TdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbUK3TdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUK3TbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:31:17 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:26505 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262283AbUK3TaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:30:20 -0500
Message-ID: <41ACCA5F.7090606@cs.aau.dk>
Date: Tue, 30 Nov 2004 19:30:39 +0000
From: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
Organization: The Umbrella Team
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20041031)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       The Umbrella Team <umbrella@cs.aau.dk>
Subject: Re: [PATCH][RFC] dynamic syscalls revisited
References: <1101741118.25841.40.camel@localhost.localdomain>	 <20041129151741.GA5514@infradead.org> <1101742562.25841.47.camel@localhost.localdomain>
In-Reply-To: <1101742562.25841.47.camel@localhost.localdomain>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>On Mon, 2004-11-29 at 15:17 +0000, Christoph Hellwig wrote:
>  
>
>>Actually they were dumped because dynamically syscalls are a really bad
>>idea, not because of implementation issues.
>>
>>    
>>
>
>Yes, for most cases they are.  But the implementation for them seemed to
>be too intrusive for the special case. This solution is not so
>intrusive, and can easily be compiled out. As I said, they are nice to
>have for a quick debugging, and may have other uses as well. The times I
>wished for them, was usually debugging a module and I didn't want to
>recompile the kernel and reboot. So instead I made awful hacks into the
>proc system or some make believe device to interface with.
>
>I'm just putting this out for others to use. If it doesn't get into the
>kernel, then so be it, but since this is not so intrusive, and can
>easily be used on all architectures, then the patch can surely help
>others.
>  
>
In our project (The Umbrella Project) we are maintaining a system call 
for making a "restricted fork" (which could e.g. be that the child 
created will have no access to the network)... it is a very annoying job 
to keep the patch up to date with the new kernel versions because the 
syscall files are changed often. The rest of the Umbrella module is 
independent because it is based on LSM ... so having dynamic syscalls is 
definitly a wish of ours!


Best, Kristian Sørensen.

-- 
Kristian Sørensen
- The Umbrella Project  --  Security for Consumer Electronics
  http://umbrella.sourceforge.net

E-mail: ipqw@users.sf.net, Phone: +45 29723816


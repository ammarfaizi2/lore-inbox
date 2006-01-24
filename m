Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWAXGEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWAXGEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 01:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWAXGEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 01:04:21 -0500
Received: from smtpout.mac.com ([17.250.248.44]:55747 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030344AbWAXGEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 01:04:21 -0500
In-Reply-To: <787b0d920601231939x1cf519e1x540316c06973de58@mail.gmail.com>
References: <787b0d920601221636h7acbb891wd52b88e0aea75aaf@mail.gmail.com> <5AB1D65D-8F03-4CDF-9847-D75143EC0A9C@mac.com> <787b0d920601221717v460283eclc72380ae541d7fef@mail.gmail.com> <m1wtgqls23.fsf@ebiederm.dsl.xmission.com> <787b0d920601231939x1cf519e1x540316c06973de58@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <55FF6D56-A5F8-47E8-89F7-E51BB22B22FF@mac.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: anon unions are cool
Date: Tue, 24 Jan 2006 01:04:16 -0500
To: Albert Cahalan <acahalan@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 23, 2006, at 22:39, Albert Cahalan wrote:
>> Then there is the other weird side where only the leaders of
>> thread groups are placed in sessions and process groups.
>
> That's not at all weird. It fits perfectly with the use of the tgid  
> as the POSIX PID and the use of the "pid" (ugh) as the POSIX thread  
> ID.
>
> Aside from POSIX just being arguably weird, the only weird things  
> here are:
>
> 1. kill() not returning errno=ESRCH when it should
> 2. the name "pid" being used oddly in the kernel

And actually, my use of the task->pid member was correct.  The "pid  
virtualization" patches are virtualizing not only the process IDs,  
but the thread IDs as well (the whole point is to provide completely  
unique PID/TID spaces, so everything needs to be virtualized).  In  
any case, it was just a poorly chosen example (because that  
particular virtualization bit was not necessary).  I agree with you  
that the kernel's behavior is weird, but it has its reasons and a lot  
of history.  If you think it's that important, a cleanup patch  
(assuming it's not too intrusive) would probably be welcomed.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer



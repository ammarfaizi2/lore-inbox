Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbSAILUn>; Wed, 9 Jan 2002 06:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286161AbSAILUe>; Wed, 9 Jan 2002 06:20:34 -0500
Received: from port-213-20-128-187.reverse.qdsl-home.de ([213.20.128.187]:62218
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S284264AbSAILUV> convert rfc822-to-8bit; Wed, 9 Jan 2002 06:20:21 -0500
Date: Wed, 09 Jan 2002 12:19:16 +0100 (CET)
Message-Id: <20020109.121916.424252478.rene.rebe@gmx.net>
To: mingo@elte.hu
Cc: davidel@xmailserver.org, kravetz@us.ibm.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.33.0201091154440.2276-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.40.0201082057560.936-100000@blue1.dev.mcafeelabs.com>
	<Pine.LNX.4.33.0201091154440.2276-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Date: Wed, 9 Jan 2002 12:37:46 +0100 (CET)

[...]

> 2.5.2-pre10-vanilla running the test at the default priority level:
> 
>     # ./chat_s 127.0.0.1
>     # ./chat_c 127.0.0.1 10 1000
> 
>     Average throughput : 124676 messages per second
>     Average throughput : 102244 messages per second
>     Average throughput : 115841 messages per second
> 
>     [ system is unresponsive at the start of the test, but
>       once the 2.5.2-pre10 load-estimator establishes which task is
>       interactive and which one is not, the system becomes usable.
>       Load can be felt and there are frequent delays in commands. ]
> 
> 2.5.2-pre10-vanilla running at nice level 19:
> 
>     # nice -n 19 ./chat_s 127.0.0.1
>     # nice -n 19 ./chat_c 127.0.0.1 10 1000
> 
>     Average throughput : 214626 messages per second
>     Average throughput : 220876 messages per second
>     Average throughput : 225529 messages per second
> 
>     [ system is usable from the beginning - nice levels are working as
>       expected. Load can be felt while executing shell commands, but the
>       system is usable. Load cannot be felt in truly interactive
>       applications like editors.
>
> Summary of throughput results: 2.5.2-pre10-vanilla is equivalent
> throughput-wise in the test with your patched kernel, but the vanilla
> kernel is about 100% faster than your patched kernel when running reniced.

Could someone tell a non-kernel-hacker why this benchmark is nearly
twice as fast when running reniced??? Shouldn't it be slower when it
runs with lower priority (And you execute / type some commands during
it)?

[...]
 
> 	Ingo

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.

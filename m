Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316636AbSFQAOA>; Sun, 16 Jun 2002 20:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSFQAN7>; Sun, 16 Jun 2002 20:13:59 -0400
Received: from jalon.able.es ([212.97.163.2]:22207 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316636AbSFQAN6>;
	Sun, 16 Jun 2002 20:13:58 -0400
Date: Mon, 17 Jun 2002 02:13:53 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Robert Love <rml@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
Message-ID: <20020617001353.GA8450@werewolf.able.es>
References: <Pine.LNX.4.44.0206161809480.9633-200000@e2> <1024271844.1476.26.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1024271844.1476.26.camel@sinai>; from rml@mvista.com on Mon, Jun 17, 2002 at 01:57:24 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.17 Robert Love wrote:
>On Sun, 2002-06-16 at 10:00, Ingo Molnar wrote:
>
>> +int idle_cpu(int cpu)
>> +{
>> +	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
>> +}
>> +
>
>I did not include this in my original O(1) backport update because
>nothing in 2.4-ac seems to use it... so why include it?
>

Well, you asked...

- the irqbalance patch for p4 needs idle_cpu (and not sure about idle_task).
  BTW, they were macros before...
- the bproc patch needs task_nice (you can be less interested in this, but
  it does not hurt...)

So could I ask you, please
- to make public idle_[cpu,task], as macros or exported functions, here it
  does not matter, irqbalance is not a module. Perhaps some other piece of code
  could need them.
- to export all the set/get prio/nice interfaces

???

Thanks.

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-pre10-jam3, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.4mdk)

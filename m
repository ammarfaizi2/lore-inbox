Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293314AbSCSAIc>; Mon, 18 Mar 2002 19:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293326AbSCSAIW>; Mon, 18 Mar 2002 19:08:22 -0500
Received: from jalon.able.es ([212.97.163.2]:45048 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S293314AbSCSAIR>;
	Mon, 18 Mar 2002 19:08:17 -0500
Date: Tue, 19 Mar 2002 01:08:09 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
        rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20020319000809.GA1647@werewolf.able.es>
In-Reply-To: <E16n74r-00024V-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.03.19 Rusty Russell wrote:
> 
>> > 	static struct myinfo mystuff __per_cpu_data;
>> > 
>> > Now how do we set mystuff.x on this CPU?
>> 
>> set_this_cpu(mystuff.x, y) could be eventually supported properly, it just
>> needs compiler work (and before that can use address calculation & reference)
>
>I think the effort would be better spent on teaching the compiler
>about these special variables, and how to do efficient assignments on
>them.
>

Not sure if suitable, but Microsoft C has a __declspec(thread) builtin
in the compiler. That beast would be fine also in gcc, something like

int	self __attribute__ ((thread));



-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Bluebird) for i586
Linux werewolf 2.4.19-pre3-jam3 #1 SMP Fri Mar 15 01:16:08 CET 2002 i686

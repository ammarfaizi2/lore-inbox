Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129547AbQLEAVd>; Mon, 4 Dec 2000 19:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130431AbQLEAVX>; Mon, 4 Dec 2000 19:21:23 -0500
Received: from [66.30.136.189] ([66.30.136.189]:12417 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S129547AbQLEAVK>; Mon, 4 Dec 2000 19:21:10 -0500
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: multiprocessor kernel problem
In-Reply-To: <20001204052123.CE84281F0@halfway.linuxcare.com.au>
Organization: none
Date: 04 Dec 2000 18:53:07 -0500
In-Reply-To: Rusty Russell's message of "Mon, 04 Dec 2000 16:21:13 +1100"
Message-ID: <m2g0k3d9r0.fsf@euler.axel.nom>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@linuxcare.com.au> writes:

> In message <m2elzp3uiq.fsf@euler.axel.nom> you write:
> > yes, but is it a dual machine or is it an N-way SMP with N > 2?  the
> > other guy with iptables/SMP problems also has a quad box.  could this
> > perhaps be a problem only when you have more than two processors?
> 
> Yes, hacked my machine to think it had 4 cpus, and boom.
> 
> There are two problems:
> (1) initialization of multiple tables was wrong, and
> (2) iterating through tables should not use cpu_number_map (doesn't
>     matter on X86 though).
> 
> Please try attached patch.

ok i'll give this a whirl .... success!

netfilter/iptables seems to be up and working on my quad ppro box
now.  i am running your "quick guide to firewalling" from the howto
until i get my rules straightened out.

thank you very much.

johan

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

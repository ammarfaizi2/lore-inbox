Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVITShc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVITShc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVITShc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:37:32 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57517 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965064AbVITShb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:37:31 -0400
Message-Id: <200509201836.j8KIajK0001419@laptop11.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nikita Danilov <nikita@clusterfs.com>, stephen.pollei@gmail.com,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Tue, 20 Sep 2005 10:43:29 MST." <43304A41.7080206@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 20 Sep 2005 14:36:45 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 20 Sep 2005 14:36:46 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
> Horst von Brand wrote:

[...]

> >It is supposed to go into the kernel, which is not exactly warning-free.

> While I have no passionate feelings about Nikita's ifdef, I must note
> that Reiser4 will always be warning free within 3 days of my finding out
> that somebody left a warning in.;-)

> I hate messy code.;-)

Me too. And I hate warnings. But what I hate most is code that has been
messed up to get an idiotic compiler to shut up. And it has been several
times that I've seen modifications to shut up the compiler, after which
modifications introduced bugs. The compiler then kept quiet due to the
"warning fix", when it would have screamed otherwise. Or where the compiler
was right in complaining, and the fix just did shut it up and did not fix
the real problem. Examples include gratuitous casts, "just initialize to
anything" so it doesn't warn about possible use without initialization.

> The rest of the kernel should be fixed to be warning free.

Unrealistic. Would be nice, but there are more pressing needs. And,as I
said above, just brute-forcing it warning-free without really understanding
what the warning is all about is /much/ worse than keeping an useless
warning.

> >Besides, you don't know what idiotic new warnings the gcc people might
> >dream up the next round, so just relying on no warnings is extremely
> >unwise.

> I find the above unconvincing.

That means you haven't used very many gcc versions. I've been around since
1.72 (or even earlier), and each single new gcc version (even minor
revisions) would complain about things the earlier ones thought were
A-OK. Even worse, to get correct code out of some versions you have to
write stuff that later versions find objectionable.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318201AbSGYBO0>; Wed, 24 Jul 2002 21:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSGYBO0>; Wed, 24 Jul 2002 21:14:26 -0400
Received: from monster.nni.com ([216.107.0.51]:9736 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318201AbSGYBNh>;
	Wed, 24 Jul 2002 21:13:37 -0400
Date: Wed, 24 Jul 2002 21:16:42 -0400
From: Andrew Rodland <arodland@noln.com>
To: Daniel Mose <imcol@unicyclist.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
Message-Id: <20020724211642.360b040c.arodland@noln.com>
In-Reply-To: <20020725022454.A8711@unicyclist.com>
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>
	<20020725022454.A8711@unicyclist.com>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002 02:24:54 +0200
Daniel Mose <imcol@unicyclist.com> wrote:

> Rob Landley wrote:
> [snip]
> What bothers my self a bit more in the kernel context, and thus 
> makes me an even more eager "Kernel alienate" than I believe Rob
> to be, are the "atomic_" calls/functions and their semantic origin.
> I believe that every Unix has "atomic_" calls all though perhaps 
> differently designed. And I totally fail to understand why some 
> one decided to name theese functions "atomic_"
> 
> To my own thinking, the atomical parts of any process in a 
> computer are puny little switches that are mostly referred to as 
> bits, and theese bits have all the software support they can get 
> even with out any "atomic_" call. I don't find anything even 
> remotely close to an electron microscope within Unix either.
> So I fail. 

Well, this one is easy enough.
"Atomic" comes from the older-than-old meaning of the word, which is,
roughly, "unsplittable" or "undivisible". Whether it uses magical CPU
instructions, or just some sort of locking mechanism, an atomic
operation is one that cannot be observed, or interfered with, "half
done".

This has lots of uses with databases, and is a major requirement there
(and a basic database book will probably explain it better than I), but
it's a big thing when you're designing an SMP/preemptive/preemptible
kernel, too. :)

Hope I was enlightening and not just boring
--hobbs

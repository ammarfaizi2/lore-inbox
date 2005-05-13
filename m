Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVEMNuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVEMNuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 09:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVEMNuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 09:50:22 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:28956 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262368AbVEMNuI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 09:50:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MauSan6Uv1o+IvCMODC7NmiCumE8fuaRIINJ+vbYabPXMWOQiZzPELYN4uhlMFdrZR8hLJNyFS/Mr/8NesKfrf/qe0rRmRHmKKMFWrwupGuYwKJ2b8pjyVQnzsVqAyTki80yWfegDxktQ6YIaLvnvHapUDO47L9ZO2YK+RL2PrI=
Message-ID: <377362e105051306506e3870a6@mail.gmail.com>
Date: Fri, 13 May 2005 22:50:08 +0900
From: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Reply-To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: Need kernel patch to compile with Intel compiler
Cc: linux-os@analogic.com, linux-kernel@vger.kernel.org
In-Reply-To: <42837C2E.9000506@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <377362e105051207461ff85b87@mail.gmail.com>
	 <Pine.LNX.4.61.0505121130030.31719@chaos.analogic.com>
	 <42837C2E.9000506@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/05, Chris Friesen <cfriesen@nortel.com> wrote:
> Richard B. Johnson wrote:
> 
> > The kernel is designed to be compiled with the GNU 'C' compler
> > supplied with every distribution. It uses a lot of __asm__()
> > statements and other GNU-specific constructions.
> 
> Yep.  And Intel added a bunch of them to their compiler so that they
> could build a kernel with it.
> 
> > Why would you even attempt to convert the kernel sources to
> > be compiled with some other tools?
> 
> The Intel compiler is quite good at optimizing for their processors (and
> ironically for AMD ones as well).  However, I think that a lot of the
> gains come from the vectorizer, which of course can't be used with
> kernel code.
> 
> Chris
> 

Yes, that's why I wanted to use Intel's compiler for kernel (of course
I didn't mean to use C++; the product's name is C++, it doesn't sell C
alone.)    Its vectorization is so nice that SETI@home calculates
20-30% faster than the original one compiled with gcc.

But I thought it's not such a good idea to build kernel with Intel
compiler, because kernel's speed doesn't affect so much in my case. 
And that vectorization isn't so effective in kernel.  PGO (profile
guided optimization) is the only effective optimization in the kernel
according to
http://softwareforums.intel.com/ids/board/message?board.id=16&message.id=1504

So I decided not to try this...looks like too much effort and little
gain.  and I guess that's why nobody is trying this now.

-- 
Luckiest in the world / Weapon of Mass Distraction
http://maverick6664.bravehost.com/
Aviation Jokes: http://www.geocities.com/tetsuji_rai/
Background: http://maverick.ns1.name/

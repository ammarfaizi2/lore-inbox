Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWEZNXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWEZNXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 09:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWEZNXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 09:23:35 -0400
Received: from [195.23.16.24] ([195.23.16.24]:51080 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1750717AbWEZNXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 09:23:34 -0400
Message-ID: <4477014E.6030104@grupopie.com>
Date: Fri, 26 May 2006 14:23:26 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Paul Drynoff <pauldrynoff@gmail.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc man page before 2.6.17
References: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com>	 <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com>	 <36e6b2150605260058h5c1fbc0cla686a37d5bf3e34e@mail.gmail.com>	 <Pine.LNX.4.58.0605261059360.30386@sbz-30.cs.Helsinki.FI>	 <36e6b2150605260120s2fb692fegf4fef1eecf7c4674@mail.gmail.com>	 <9a8748490605260248i68a1eb84hc241068ae1f012bb@mail.gmail.com> <36e6b2150605260344l1ba91d56we2d224d49bde4d8e@mail.gmail.com>
In-Reply-To: <36e6b2150605260344l1ba91d56we2d224d49bde4d8e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Drynoff wrote:
> [...]
> + * %GFP_USER - Allocate memory on behalf of user.  May sleep.
> + *
> + * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
> + *
> + * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt 
> handlers.

I find this comment to be a little misleading. GFP_ATOMIC should be used 
on _any_ code that can not sleep, including sections protected by a 
spinlock and sections that run with IRQ's disabled, no?

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?

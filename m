Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSIFJ0z>; Fri, 6 Sep 2002 05:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318291AbSIFJ0z>; Fri, 6 Sep 2002 05:26:55 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:43298 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S318290AbSIFJ0y>;
	Fri, 6 Sep 2002 05:26:54 -0400
Date: Fri, 6 Sep 2002 12:28:29 +0300
From: Dan Aloni <da-x@gmx.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Message-ID: <20020906092829.GA32379@callisto.yi.org>
References: <20020902003318.7CB682C092@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020902003318.7CB682C092@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 03:23:02PM +1000, Rusty Russell wrote:
> This week, it spread to SCTP.
> 
> "struct list_head" isn't a great name, but having two names for
> everything is yet another bar to reading kernel source.
> 
[...]
> 
> D: This removes list_t, which is a gratuitous typedef for a "struct
> D: list_head".  Unless there is good reason, the kernel doesn't usually
> D: typedef, as typedefs cannot be predeclared unlike structs.
> 

Good, I see it was actually a *good* thing that I've done a 
's/struct list_head/list_t' in list.h, back when I was adding list_move_*(). 

Otherwise, we wouldn't have noticed much the appearance of list_t, and it 
might have spread throughout the kernel by the time we reach 2.6.0.

task_t, anyone?

-- 
Dan Aloni
da-x@gmx.net

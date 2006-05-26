Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWEZVkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWEZVkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWEZVkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:40:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751626AbWEZVkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:40:21 -0400
Date: Fri, 26 May 2006 14:43:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/13] input: make input a multi-object module
Message-Id: <20060526144309.60469bcd.akpm@osdl.org>
In-Reply-To: <44777340.7030905@gmail.com>
References: <20060526161129.557416000@gmail.com>
	<20060526162902.227348000@gmail.com>
	<20060526141603.054f0459.akpm@osdl.org>
	<44777340.7030905@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anssi Hannula <anssi.hannula@gmail.com> wrote:
>
> Andrew Morton wrote:
> > Anssi Hannula <anssi.hannula@gmail.com> wrote:
> > 
> >>Move the input.c to input-core.c and modify Makefile so that the input module
> >>can be built from multiple source files. This is preparing for the input-ff.c.
> >>
> >>Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
> >>
> >>---
> >> drivers/input/Makefile     |    2 
> >> drivers/input/input-core.c | 1099 +++++++++++++++++++++++++++++++++++++++++++++
> >> drivers/input/input.c      | 1099 ---------------------------------------------
> > 
> > urgh.  There are other changes pending againt input.c and this renaming
> > makes everything a huge pain.
> > 
> > What does "can be built from multiple source files" mean?
> 
> Well, I want to embed the input-ff.c into the input module too.

What does "embed" mean?  #include a .c file, or what?  (If "yes" then "no",
there's enough of that happening and it's an awful thing to do).

> > It would be much nicer all round if we could avoid renaming this file.
> 
> Indeed... There are these 4 options as far as I see:
> 
> 1. Do this rename
> 2. Put all the code in input-ff.c to input.c
> 3. Make the input-ff a separate bool "module" and add
> EXPORT_SYMBOL_GPL() for input_ff_event() which is currently the only
> function in input-ff.c that is called from input.c
> 4. Rename the input "module" to something else, it doesn't matter so
> much as almost everybody builds it as built-in anyway.
> 
> WDYT is the best one?

I still don't know what problem you're trying to solve so I cannot say.

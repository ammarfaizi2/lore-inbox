Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130886AbRBLPvD>; Mon, 12 Feb 2001 10:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRBLPuy>; Mon, 12 Feb 2001 10:50:54 -0500
Received: from [64.64.109.142] ([64.64.109.142]:2823 "EHLO quark.didntduck.org")
	by vger.kernel.org with ESMTP id <S130886AbRBLPud>;
	Mon, 12 Feb 2001 10:50:33 -0500
Message-ID: <3A880628.F77E3ACA@didntduck.org>
Date: Mon, 12 Feb 2001 10:50:00 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Rush <brush@cse.unl.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Error Communicating With Module
In-Reply-To: <Pine.SGI.4.05.10102120911460.4669542-100000@cse.unl.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Rush wrote:
> 
>         Hello, first of all I must tell you that I do not belong to this
> mailing list as of yet, so, please respond to me via brush@cse.unl.edu.
> Thank you very much in advance!
> 
>         My problem is as follows:
> 
>         I have added a variable named bens_variable to ksyms.c as follows:
> 
>         extern int bens_variable=10;
> 
>         I have then exported the variable in ksyms.c as follows:
> 
>         EXPORT_SYMBOL(bens_variable);
> 
>         I then recompiled the kernel as bzImage and everything went
> perfectly fine. I then wrote a module for that particular kernel which
> is simple and looks as follows:
> 
>         #define MODULE
>         #define __KERNEL__
>         #include <linux/module.h>
> 
>         int init_module(void){
>                 printk(bens_variable);
>                 return 0;
>         }
> 
>         void cleanup_module(void){
>                 printk("<1>Module Unloaded\n");
>         }
> 
>         But, of course, whenever I try and compile the module to load it
> using gcc it tells me that bens_variable is undefined - which makes sense,
> however I don't see how I can compile this without typing in
> 
>         extern int bens_variable;
> 
>         again. How do I get my module to compile and print out the value
> of bens_variable as defined within ksyms.c?

Turn module versioning off.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRBLQX0>; Mon, 12 Feb 2001 11:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131373AbRBLQXQ>; Mon, 12 Feb 2001 11:23:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:47233 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131346AbRBLQXG>; Mon, 12 Feb 2001 11:23:06 -0500
Date: Mon, 12 Feb 2001 11:22:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brian Gerst <bgerst@didntduck.org>
cc: Ben Rush <brush@cse.unl.edu>, linux-kernel@vger.kernel.org
Subject: Re: Error Communicating With Module
In-Reply-To: <3A880628.F77E3ACA@didntduck.org>
Message-ID: <Pine.LNX.3.95.1010212111318.9275A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Brian Gerst wrote:

> Ben Rush wrote:
> > 
> >         Hello, first of all I must tell you that I do not belong to this
> > mailing list as of yet, so, please respond to me via brush@cse.unl.edu.
> > Thank you very much in advance!
> > 
> >         My problem is as follows:
> >         I have added a variable named bens_variable to ksyms.c as follows:
> >         extern int bens_variable=10;
            ^^^^^^

Yes. But where is this allocated?? This statement says that it's
someplace else.

Remove "extern".

[SNIPPED]
> > 
> >         #define MODULE
> >         #define __KERNEL__
> >         #include <linux/module.h>
> >

	... add:

	    extern int bens_variable;
 
> >         int init_module(void){
> >                 printk(bens_variable);
> >                 return 0;
> >         }
> > 
> >         void cleanup_module(void){
> >                 printk("<1>Module Unloaded\n");
> >         }
> > 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/

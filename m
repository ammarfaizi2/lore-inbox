Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSCRXvK>; Mon, 18 Mar 2002 18:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292733AbSCRXvB>; Mon, 18 Mar 2002 18:51:01 -0500
Received: from rj.sgi.com ([204.94.215.100]:2269 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S291401AbSCRXuq>;
	Mon, 18 Mar 2002 18:50:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Carl Spalletta <cspalletta@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc inline asm - short question 
In-Reply-To: Your message of "Mon, 18 Mar 2002 15:27:40 -0800."
             <20020318232740.39289.qmail@web13305.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Mar 2002 10:50:36 +1100
Message-ID: <18113.1016495436@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002 15:27:40 -0800 (PST), 
Carl Spalletta <cspalletta@yahoo.com> wrote:
>        asm ( assembler template
>	    : output operands			 	(optional)
>	    : input operands			 	(optional)
>	    : list of clobbered registers 	  	(optional)
>	    );	
>
>  I have read all the docs and I still can't clearly understand when it 
>is required to specify a clobberlist - a register or memory that will
>be modified and must be preserved by gcc.

The clobber list is _extra_ clobbers, registers or memory that gcc
cannot deduce from the other parameters.  =d" (xloops), "=&a" (d0)
already tells gcc that edx and eax are used, you do not need to
explicitly specify them as clobbers.  OTOH, asm ("mov 1, %eax")
requires a clobber because the operands do not mention eax.


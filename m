Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274269AbRI3XfX>; Sun, 30 Sep 2001 19:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274270AbRI3XfN>; Sun, 30 Sep 2001 19:35:13 -0400
Received: from mnh-1-20.mv.com ([207.22.10.52]:39174 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S274269AbRI3XfB>;
	Sun, 30 Sep 2001 19:35:01 -0400
Message-Id: <200110010053.TAA03739@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: bruce@cs.usyd.edu.au (Bruce Janson)
cc: linux-kernel@vger.kernel.org
Subject: Re: the fault address of a traced process 
In-Reply-To: Your message of "Sun, 30 Sep 2001 22:47:06 +1100."
             <20010930125931Z273463-760+18683@vger.kernel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Sep 2001 19:53:17 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bruce@cs.usyd.edu.au said:
> The tracer now wants to determine the traced process' faulted address.
> According to the (2.2.19) kernel source 
 [snip]
> How should a tracer extract this information under a current (2.2.*,
> 2.4.*) Linux? 

Read some more UML source, specifically, 

segv_handler() in arch/um/kernel/trap_user.c and also the i386 definitions
in arch/um/include/sysdep-i386/sigcontext.h

Basically, you are passed the necessary information in a sigcontext struct.

				Jeff


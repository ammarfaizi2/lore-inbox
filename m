Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbREVP6E>; Tue, 22 May 2001 11:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbREVP5y>; Tue, 22 May 2001 11:57:54 -0400
Received: from t2.redhat.com ([199.183.24.243]:46578 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261969AbREVP5t>; Tue, 22 May 2001 11:57:49 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E152DEZ-0001y7-00@the-village.bc.nu> 
In-Reply-To: <E152DEZ-0001y7-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bodnar42@bodnar42.dhs.org (Me), jaharkes@cs.cmu.edu (Jan Harkes),
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/coda.h 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 May 2001 16:57:24 +0100
Message-ID: <26524.990547044@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Why is your cross compiler outputting different symbols to a linux
> native  compiler ?

> If __linux__ is not defined by the cross compiler, then the cross
> compiler is broken. A cross compiler has the same environment as the
> native compiler for the target. The only stuff that should break (well
> should as in might) is  tools native built

> Or am I misunderstanding the report ?

Why use a cross compiler? With the obvious exception of UML, the Linux
kernel is not a Linux executable, so why should it need to be compiled with
a compiler which targets such? 

The kernel compiles quite happily with compilers which aren't targetted 
specifically at Linux -- the CODA compatibility cruft being the one 
exception. I often just comment out the CODA includes from <linux/fs.h> to 
get round the same problem.

--
dwmw2



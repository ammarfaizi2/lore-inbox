Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293667AbSCESYZ>; Tue, 5 Mar 2002 13:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293677AbSCESYP>; Tue, 5 Mar 2002 13:24:15 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:21509 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S293667AbSCESYC>;
	Tue, 5 Mar 2002 13:24:02 -0500
Date: Tue, 5 Mar 2002 19:23:51 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: FPU precision & signal handlers (bug?)
In-Reply-To: <E16i15h-0000q9-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203051919280.7951-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 4 Mar 2002, Alan Cox wrote:

> > handlers. We use signals extensively in our program, and were quite
> > surprised to find kernel FINIT traps being generated from them. After
> > reading through the 2.4.2 source, I now believe that all signal
> > handlers run with the default FPU control word in effect. Here's
> > why...
>
> Think about MMX and hopefully it makes sense then.

AFAIR MMX only mucks with tag and status words (and the exponent fields of
the stack elements), but never depends on or modifies the control word.

>
> > strikes me as kind of a hack. Why should the signal handler, alone
> > among all my functions (excepting main) be responsible for blowing
> > away the control word?
>
> Right - I would expect it to be restored at the end of the signal handler
> for you - is that occuring or not ? I just want to make sure I understand
> the precise details of the problem here.

State is restored properly at end of signal handler, it always worked
fine, no problem there...

	Gabriel.


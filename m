Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289022AbSAUDJV>; Sun, 20 Jan 2002 22:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289021AbSAUDJL>; Sun, 20 Jan 2002 22:09:11 -0500
Received: from fe1.rdc-kc.rr.com ([24.94.163.48]:35340 "EHLO mail1.kc.rr.com")
	by vger.kernel.org with ESMTP id <S289017AbSAUDJC>;
	Sun, 20 Jan 2002 22:09:02 -0500
To: vic <zandy@cs.wisc.edu>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
In-Reply-To: <m3adwc9woz.fsf@localhost.localdomain>
	<87g0632lzw.fsf@mathdogs.com> <m3advcq5jv.fsf@localhost.localdomain>
Date: 20 Jan 2002 21:09:00 -0600
In-Reply-To: <m3advcq5jv.fsf@localhost.localdomain>
Message-ID: <87665wbdtf.fsf@mathdogs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Mike Coleman" <mkc+dated+1012446540.067c74@mathdogs.com>
X-Delivery-Agent: TMDA/0.44 (Python 2.1.1; linux-i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vic <zandy@cs.wisc.edu> writes:
> From: Mike Coleman <mkc@mathdogs.com>:
> > Also, is this something that used to work?  Or would this be a change in the
> > semantics of ptrace?
> 
> This is a change of semantics at least going back to 2.2.

Okay.  Is it at least backward compatible?  Or are some tools expected to
break?

> > Unless I'm missing something (frequently the case), there are two cases here:
> > (1) the tracer wants to leave the tracee stopped, and (2) the tracer wants the
> > process to continue running in as natural a way as possible, meaning without
> > sending it a SIGCONT (which can cause the SIGCONT signal handler to execute).
> > As things currently stand, we have behavior (2), and (1) is not possible.
> > With your change, we'd have behavior (1), and (2) would not be possible.
> 
> I agree that the ability to do (2) should be preserved, but I don't
> see how this patch breaks it; do you have an example?

No, I was just going by reading the kernel code.  Can you describe how each of
(1) and (2) are accomplished by the ptracing program (with your patch)?

Mike

Return-Path: <linux-kernel-owner+w=401wt.eu-S932790AbWLaWQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbWLaWQe (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 17:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933236AbWLaWQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 17:16:33 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:4586 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932790AbWLaWQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 17:16:33 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.19.1
Date: Sun, 31 Dec 2006 22:16:58 +0000
User-Agent: KMail/1.9.5
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
References: <200612311646_MC3-1-D6DD-9566@compuserve.com>
In-Reply-To: <200612311646_MC3-1-D6DD-9566@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612312216.58541.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 December 2006 21:43, Chuck Ebbert wrote:
> In-Reply-To: <200612301829.15980.s0348365@sms.ed.ac.uk>
>
> On Sat, 30 Dec 2006 18:29:15 +0000, Alistair John Strachan wrote:
> > > Can you post disassembly of pipe_poll() for both the one that crashes
> > > and the one that doesn't?  Use 'objdump -D -r fs/pipe.o' so we get the
> > > relocation info and post just the one function from each for now.
> >
> > Sure, no problem:
> >
> > http://devzero.co.uk/~alistair/2.6.19-via-c3-pipe_poll/
> >
> > Both use identical configs, neither are optimised for size. The config is
> > available from the same location.
>
> Those were compiled without frame pointers.  Can you post them compiled
> with frame pointers so they match your original bug report? And confirm
> that pipe_poll() is still at 0xc0156ec0 in vmlinux?

c0156ec0 <pipe_poll>:

I used the config I original sent you to rebuild it again. This time I've put 
up the whole vmlinux for both kernels, the config is replaced, the 
decompilation is re-done, I've confirmed the offset in the GCC 4.1.1 kernel 
is identical. Sorry for the confusion.

The reason I changed the configs was to experiment with enabling and disabling 
debugging (and other such) options that might have shaken out compiler bugs.

However none of these kernels have ever crashed gracefully again, most of them 
hang the machine (no nmi watchdog though) so I've not been able to look at 
the oops. It's the same root cause, however, as GCC 3.4.6 kernels do not 
crash.

http://devzero.co.uk/~alistair/2.6.19-via-c3-pipe_poll/

Happy new year, btw.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

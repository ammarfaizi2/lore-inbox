Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136788AbREIRus>; Wed, 9 May 2001 13:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136787AbREIRuj>; Wed, 9 May 2001 13:50:39 -0400
Received: from upright.CS.Princeton.EDU ([128.112.136.7]:56492 "EHLO
	upright.CS.Princeton.EDU") by vger.kernel.org with ESMTP
	id <S136785AbREIRu1>; Wed, 9 May 2001 13:50:27 -0400
From: "Scott C. Karlin" <scott@CS.Princeton.EDU>
Message-Id: <200105091750.f49HoEg20765@chinstrap.CS.Princeton.EDU>
Subject: Nasty Requirements for non-GPL Linux Kernel Modules?
To: linux-kernel@vger.kernel.org
Date: Wed, 9 May 2001 13:50:13 -0400 (EDT)
Reply-To: scott@CS.Princeton.EDU
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that Linus Torvalds has stated that it is possible
to have a non-GPL'd (or even binary only) Linux device driver
kernel module dynamically linked to the kernel "assuming all
the nasty requirements are met." [see reference below]

What, specifically, are the "nasty requirements?"

  * Is it simply that it must compile separately from the kernel
    and load via insmod?

  * May I #include kernel header files in my module?

  * If so, which ones?

  * What if these header files have inline functions?
    (Does it matter?)

If I don't hear from Linus directly, can someone point me to
a document, file, or mailing list thread where this might be
spelled out.

As part of our operating system / networking research, we have
written a loadable kernel module for Linux.  We would like to
distribute the source but we're not sure if our development
office will allow us to release it under the GPL (at least
initially).  Before meeting with the lawyers, I'm trying to
learn what I can about the issue.

Thanks,
Scott


Reference:

Linux Kernel mailing list thread, "Is it OK to release non-GPL
network driver with source?" started 06 Sep 2000.  Specifically,
see http://lists.insecure.org/linux-kernel/2000/Sep/1491.html
which is copied here:

On 07 Sep 2000, Linus Torvalds writes:
>
> In article <20000906161126.B30302@ranma.sysrq.org>, Dave Allen wrote: 
> > 
> > My company is currently working on a linux network driver (I'm sorry, 
> > but I can't disclose which company or the nature of the driver right 
> > now). However, recent discussions on this list have made me grow 
> > concerned about licensing problems with the GPL. 
> > 
> > The source code for the driver _is_ going to be available, but it will 
> > not be GPL'd. 
> 
> Note that whenever it's not GPL'd, all the module restrictions kick in. 
> So it's going to be "legal" the same way any binary only module is 
> "legal" - assuming all the nasty requirements are met. For something as 
> simple (from a conceptual standpoint, not necessarily an implementation 
> standpoint) as a network driver, doing that is not likely to be a big 
> problem. 
> 
> It obviously cannot be linked into the kernel, but as a loadable module 
> it's ok as long as it uses the standard interfaces and nothing more. 
> 
> And sure, having source available might make it easier for people to 
> help you: it can't become part of the standard kernel, and as such it 
> will never be supported, but that's true of binary-only modules too. 
> 
> I wouldn't recommend it, but I don't see that it would be an 
> insurmountable problem. 
> 
>         Linus 

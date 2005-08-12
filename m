Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVHLFa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVHLFa2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 01:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVHLFa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 01:30:28 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:29103 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751061AbVHLFa1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 01:30:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fpwbSMyb+0gE1ZC5KUfsxFzcMfgfCtocCeE1MonoJHhPXXlMgPXGaGB4yP1fqcmverS07e3Wv6K2gOKebkAdXW23fo081J0Qc0Wg8Kkqt+18HfPMfWPfy5Vq1AN0+23MiNHKpgl6ZEMcy7w3grBEvH76c+TgHjxYZVeDF5volzQ=
Message-ID: <2cd57c900508112230c2c383b@mail.gmail.com>
Date: Fri, 12 Aug 2005 13:30:19 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Jeff Carr <jcarr@linuxmachines.com>
Subject: Re: Need help in understanding x86 syscall
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42FC2DE4.4010608@linuxmachines.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4Ae73-6Mm-5@gated-at.bofh.it>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
	 <1123777184.17269.67.camel@localhost.localdomain>
	 <2cd57c90050811093112a57982@mail.gmail.com>
	 <2cd57c9005081109597b18cc54@mail.gmail.com>
	 <1123780681.17269.71.camel@localhost.localdomain>
	 <42FC2DE4.4010608@linuxmachines.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/05, Jeff Carr <jcarr@linuxmachines.com> wrote:
> On 08/11/2005 10:18 AM, Steven Rostedt wrote:
> 
> > It's vanilla 2.6.12-rc3 + Ingo's RT V0.7.46-02-rs-0.4 + some of my own
> > customizations.  But I never touched the sysentry stuff and with a few
> > printks I see it is being initialized.
> >
> >>Also glibc support.
> >
> > I'm using Debian unstable with a recent (last week) update.
> >
> > -- Steve
> 
> But are you using libc6-i686? That enables NPTL. Perhaps the behavior
> difference is there? I'm surprised int 80 doesn't really cause an
> interrupt; it doesn't jump to the appropriate place in the x86 vector
> table? Interesting.
> 
> Jeff
> 
> 
> root@jcarr:~# dpkg -s libc6-i686
> ...
>  This set of libraries is optimized for i686 machines, and will only be
>  used if you are running a 2.6 kernel on an i686 class CPU (check the
>  output of `uname -m').  This includes Pentium Pro, Pentium II/III/IV,
>  Celeron CPU's and similar class CPU's (including clones such as AMD
>  Athlon/Opteron, VIA C3 Nehemiah, but not VIA C3 Ezla).
>  .
>  This package includes support for NPTL.
>  .

Even with libc6-i686 installed, I can't see sysenter got used.
libc6-i686 has /lib/tls/i686/cmov/libc.so.6, not the one
/lib/libc-2.3.5.so.

mozilla gets: Illegal instruction

I've added ud2 in both entry.S and vsyscall-sysenter.S.

Any ideas?

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/

Return-Path: <linux-kernel-owner+w=401wt.eu-S933199AbWLaQsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199AbWLaQsT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 11:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933200AbWLaQsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 11:48:19 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:4032 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933199AbWLaQsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 11:48:19 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Oops in 2.6.19.1
Date: Sun, 31 Dec 2006 16:48:43 +0000
User-Agent: KMail/1.9.5
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <200612301224_MC3-1-D6C5-9FCD@compuserve.com> <200612301829.15980.s0348365@sms.ed.ac.uk> <20061231162830.GL20714@stusta.de>
In-Reply-To: <20061231162830.GL20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612311648.43159.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 December 2006 16:28, Adrian Bunk wrote:
> On Sat, Dec 30, 2006 at 06:29:15PM +0000, Alistair John Strachan wrote:
> > On Saturday 30 December 2006 17:21, Chuck Ebbert wrote:
> > > In-Reply-To: <200612301659.35982.s0348365@sms.ed.ac.uk>
> > >
> > > On Sat, 30 Dec 2006 16:59:35 +0000, Alistair John Strachan wrote:
> > > > I've eliminated 2.6.19.1 as the culprit, and also tried toggling
> > > > "optimize for size", various debug options. 2.6.19 compiled with GCC
> > > > 4.1.1 on an Via Nehemiah C3-2 seems to crash in pipe_poll reliably,
> > > > within approximately 12 hours.
> > >
> > > Which CPU are you compiling for?  You should try different options.
> >
> > I should, I haven't thought of that. Currently it's compiling for
> > CONFIG_MVIAC3_2, but I could try i686 for example.
> >
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
> Can you try enabling as many debug options as possible?

Specifically what? I've already had:

CONFIG_DETECT_SOFTLOCKUP
CONFIG_FRAME_POINTER
CONFIG_UNWIND_INFO

Enabled. CONFIG_4KSTACKS is disabled. Are there any debugging features 
actually pertinent to this bug?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

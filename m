Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSGYOY5>; Thu, 25 Jul 2002 10:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSGYOY5>; Thu, 25 Jul 2002 10:24:57 -0400
Received: from [62.47.148.207] ([62.47.148.207]:8576 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S314078AbSGYOY4>;
	Thu, 25 Jul 2002 10:24:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Thomas Winischhofer <thomas@winischhofer.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Errors in 2.4.19-rc3 CML rules (SiS related)
Date: Thu, 25 Jul 2002 16:01:06 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17XjAw-0005XU-00@oland.twinny.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2002-07-24 at 11:22, Scott Bronson wrote:
> >   1) CONFIG_DRM_SIS needs to require CONFIG_FB_SIS_315.
> >       Currently, you can select CONFIG_DRM_SIS without 
> >       CONFIG_FB_SIS_315. If you do that, you get undefined symbol 
> >       errors for sis_malloc and sis_free.

Not true. DRM_SIS does NOT require FB_SIS_315. It requires either 
FB_SIS_300 *or* FB_SIS_315. (But since DRI is not supported on the 315 
series, that whole issue does not make much sense...) 

>   2) CONFIG_FB_SIS must be compiled into the kernel (i.e. NOT a 
>      module).

Not true either. If you compile DRM as a module as well, you don't get 
any unresolved symbols. So it's either 1) both into the kernel, 2) 
both as modules or 3) sisfb into the kernel and DRM as a module.

> >      Currently, you can compile it as a module.
> >      If you do that, you ALSO get undefined symbol errors for
> >         sis_malloc and sis_free.
>
> These requirements could be enforced with CML rules.  Before I
> submit the patch to do this, I'd like to know if that's the proper
> fix!  Would it be better to just make CONFIG_FB_SIS able to be built
> as a module instead?

> For the rules - go for it. 

No, please don't.

> For the modular driver ping the sisfb
> maintainer first and check what is in the pipeline.

Erm, that's me I think (apart from the fbdev api stuff)... Well, not 
much for now as I am on vacation.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net		http://www.winischhofer.net/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSHBNnX>; Fri, 2 Aug 2002 09:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSHBNnX>; Fri, 2 Aug 2002 09:43:23 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33296 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313537AbSHBNnW>;
	Fri, 2 Aug 2002 09:43:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@suse.de>
Cc: Felipe W Damasio <felipewd@terra.com.br>,
       Linux-kernel <linux-kernel@vger.kernel.org>, trivial@rustcorp.com.au
Subject: Re: [PATCH] __devexit_p macro 
In-reply-to: Your message of "Fri, 02 Aug 2002 14:33:49 +0200."
             <20020802143348.G25761@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Aug 2002 23:46:39 +1000
Message-ID: <3483.1028295999@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002 14:33:49 +0200, 
Dave Jones <davej@suse.de> wrote:
>On Fri, Aug 02, 2002 at 09:24:56AM +0000, Felipe W Damasio wrote:
> > +#ifdef MODULE || CONFIG_HOTPLUG
> > +#define __devexit_p(x)  &(x)
> > +#else
> >  #define __devexit_p(x)  0
> >  #endif
>
>Instead of making this a maze of #if/else's, you can acheive
>the same effect with the following patch that has been in my
>tree for a few months.. (hand pasted, may not apply cleanly)

Better still, copy the end of 2.5.19-rc5/include/linux/init.h to
2.5.30, from #ifdef CONFIG_HOTPLUG onwards.  There is no point in
having slight differences between the 2.4 and 2.5 versions, ATM they
should be the same.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271761AbRHRBYT>; Fri, 17 Aug 2001 21:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271760AbRHRBYI>; Fri, 17 Aug 2001 21:24:08 -0400
Received: from h08004614c48b.ne.mediaone.net ([66.31.21.118]:56836 "EHLO noop.")
	by vger.kernel.org with ESMTP id <S271759AbRHRBXu>;
	Fri, 17 Aug 2001 21:23:50 -0400
To: Dave Morgan <daves_spam_account@yahoo.com>
Cc: acpi@phobos.fachschaften.tu-muenchen.de, linux-kernel@vger.kernel.org
Subject: AGP support locks X - was Re: sony vaio, crude workaround
In-Reply-To: <20010817124100.12469.qmail@web20304.mail.yahoo.com>
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: 17 Aug 2001 21:20:33 -0400
In-Reply-To: <20010817124100.12469.qmail@web20304.mail.yahoo.com> (Dave Morgan's message of "Fri, 17 Aug 2001 05:41:00 -0700 (PDT)")
Message-ID: <m3itfmrwny.fsf@coelacanth.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This solved the problem.  Apparently AGP has to be built as a module
in kernels v2.4.8 or X will lock up?  Anyone else experience this?

> I'm not sure that this is the problem you are having,
> but I had a problem with X when I was playing with the
> ACPI stuff and recompiling the kernel on my vaio. Try 
> setting CONFIG_AGP=m (i.e. make AGP support a module,
> as opposed to being compiled in-kernel.) if it isn't. 
> Once I did that, X started up just fine. Good luck.
> 
> Dave


Dave Morgan <daves_spam_account@yahoo.com> writes:
> >> I tried this and it doesn't disable the console. 
> The /proc/acpi
> >> represents the correct power status.  When I tried
> to
> >> start up X the following error occurs:
> >> 
> >> I810 Dma Initialization Failed
> >> XIO:  fatal IO error 104 (Connection reset by peer)
> >on X server 
> >":0.0"
> >>       after 0 requests (0 known processed) with 0
> >events remaining.
> >> 
> >> So the work around must break something else?
> 
> >Follup:  
> 
> >This isn't because of the ACPI code.  It's something
> >that happens in
> >my 2.4.8 kernel wo ACPI compiled in.  This behavior
> is >not shown with
> >the 2.2.16 kernel.
> 

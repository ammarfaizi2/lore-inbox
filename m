Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVG1Oc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVG1Oc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVG1OcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:32:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8197 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261510AbVG1OcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:32:07 -0400
Date: Thu, 28 Jul 2005 16:32:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New include file for marking old style api files
Message-ID: <20050728143203.GJ3528@stusta.de>
References: <42E8E0C2.5010302@gmail.com> <20050728140230.GG3528@stusta.de> <42E8E6BD.90807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E8E6BD.90807@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 04:07:57PM +0200, Jiri Slaby wrote:
> Adrian Bunk napsal(a):
> 
> >On Thu, Jul 28, 2005 at 03:42:26PM +0200, Jiri Slaby wrote:
> > 
> >
> >>Hi.
> >>Do you think, that this would be useful in the kernel tree?
> >>I have an idea to mark old drivers, which should I or somebody rewrite.
> >>For example drivers/isdn/hisax/gazel.c.
> >>...
> >>--- /dev/null
> >>+++ b/include/linux/oldapi.h
> >>@@ -0,0 +1,2 @@
> >>+#warning This driver uses old style API and needs to be rewritten or 
> >>removed \
> >>+	from kernel
> >>   
> >>
> >
> >What's wrong with __deprecated ?
> > 
> >
> Nothing, but this marks entire driver, not a function, that it uses.
> I.e. gazel doesn't emit any warning or so, I think; so for these cases.

Why do you require a header file for this?
Simply put the #warning in gazel.c .

If the API is scheduled for removal, you should put the #warning in the 
header file for the API.

If the API is old but is expected to stay for a longer time, simply do 
nothing. Artificially increasing the warnings during kernel compilation 
only makes it harder to find important warnings.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


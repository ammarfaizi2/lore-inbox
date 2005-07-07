Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVGGJ3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVGGJ3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 05:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVGGJ3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 05:29:07 -0400
Received: from [203.171.93.254] ([203.171.93.254]:45705 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261244AbVGGJ3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 05:29:06 -0400
Subject: Re: [PATCH] [37/48] Suspend2 2.1.9.8 for 2.6.12:
	613-pageflags.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka Enberg <penberg@gmail.com>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f0205070605012517003a@mail.gmail.com>
References: <11206164393426@foobar.com> <11206164434190@foobar.com>
	 <84144f0205070605012517003a@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120728625.4860.1113.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 07 Jul 2005 19:30:28 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 22:01, Pekka Enberg wrote:
> On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> > diff -ruNp 614-plugins.patch-old/kernel/power/suspend2_core/plugins.c 614-plugins.patch-new/kernel/power/suspend2_core/plugins.c
> > --- 614-plugins.patch-old/kernel/power/suspend2_core/plugins.c  1970-01-01 10:00:00.000000000 +1000
> > +++ 614-plugins.patch-new/kernel/power/suspend2_core/plugins.c  2005-07-04 23:14:19.000000000 +1000
> > @@ -0,0 +1,341 @@
> > +#define FILTER_PLUGIN 1
> > +#define WRITER_PLUGIN 2
> > +#define MISC_PLUGIN 4 // Block writer, eg.
> > +#define CHECKSUM_PLUGIN 5
> > +
> > +#define SUSPEND_ASYNC 0
> > +#define SUSPEND_SYNC  1
> 
> Enums are preferred.
> 
> > +
> > +#define SUSPEND_COMMON_IO_OPS \
> > +       /* Writing the image proper */ \
> > +       int (*write_chunk) (struct page * buffer_page); \
> > +\
> > +       /* Reading the image proper */ \
> > +       int (*read_chunk) (struct page * buffer_page, int sync); \
> > +\
> > +       /* Reset plugin if image exists but reading aborted */ \
> > +       void (*noresume_reset) (void);
> 
> Please remove the above macro obfuscation.

Done. Thanks!

Nigel

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 


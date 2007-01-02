Return-Path: <linux-kernel-owner+w=401wt.eu-S1755123AbXABCgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbXABCgt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 21:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbXABCgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 21:36:49 -0500
Received: from xenotime.net ([66.160.160.81]:33124 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755123AbXABCgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 21:36:48 -0500
Date: Mon, 1 Jan 2007 18:23:22 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/8] UML - audio driver formatting
Message-Id: <20070101182322.b365543a.rdunlap@xenotime.net>
In-Reply-To: <4599BAE1.9050804@student.ltu.se>
References: <200701011947.l01JlAMo020761@ccure.user-mode-linux.org>
	<4599BAE1.9050804@student.ltu.se>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jan 2007 02:52:33 +0100 Richard Knutsson wrote:

> Jeff Dike wrote:
> > Whitespace and style fixes.
> >
> > Signed-off-by: Jeff Dike <jdike@addtoit.com>
> > --
> >  arch/um/drivers/hostaudio_kern.c |  160 +++++++++++++++++----------------------
> >  1 file changed, 73 insertions(+), 87 deletions(-)
> >
> > Index: linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c
> > ===================================================================
> > --- linux-2.6.18-mm.orig/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:41.000000000 -0500
> > +++ linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:42.000000000 -0500
> > @@ -15,11 +15,11 @@
> >  #include "os.h"
> >  
> >  struct hostaudio_state {
> > -  int fd;
> > +	int fd;
> >  };
> >  
> >  struct hostmixer_state {
> > -  int fd;
> > +	int fd;
> >  };
> >  
> >  #define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
> > @@ -72,12 +72,12 @@ MODULE_PARM_DESC(mixer, MIXER_HELP);
> >  static ssize_t hostaudio_read(struct file *file, char __user *buffer,
> >  			      size_t count, loff_t *ppos)
> >  {
> > -        struct hostaudio_state *state = file->private_data;
> > +	struct hostaudio_state *state = file->private_data;
> >  	void *kbuf;
> >  	int err;
> >  
> >  #ifdef DEBUG
> > -        printk("hostaudio: read called, count = %d\n", count);
> > +	printk("hostaudio: read called, count = %d\n", count);
> >  #endif
> >  
> >  	kbuf = kmalloc(count, GFP_KERNEL);
> > @@ -91,7 +91,7 @@ static ssize_t hostaudio_read(struct fil
> >  	if(copy_to_user(buffer, kbuf, err))
> >  		err = -EFAULT;
> >  
> > - out:
> > +out:
> >   
> Isn't labels _suppose_ to be spaced? (due to "grep", if I'm not mistaken)...

There was some noise about that (due to 'patch' IIRC).
I tested it and could not cause a problem with labels beginning
in column 0.  Can you?

> >  	kfree(kbuf);
> >  	return(err);
> >  }



---
~Randy

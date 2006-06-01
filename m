Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWFAUGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWFAUGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWFAUGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:06:44 -0400
Received: from xenotime.net ([66.160.160.81]:235 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030263AbWFAUGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:06:43 -0400
Date: Thu, 1 Jun 2006 13:09:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: input: fix comments and blank lines in new ff code
Message-Id: <20060601130923.38f83fb6.rdunlap@xenotime.net>
In-Reply-To: <447F47FD.2050705@gmail.com>
References: <20060530105705.157014000@gmail.com>
	<20060530110131.136225000@gmail.com>
	<20060530222122.069da389.rdunlap@xenotime.net>
	<447F3AE4.6010206@gmail.com>
	<20060601125256.de2897f4.rdunlap@xenotime.net>
	<447F47FD.2050705@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 23:03:09 +0300 Anssi Hannula wrote:

> Randy.Dunlap wrote:
> > On Thu, 01 Jun 2006 22:07:16 +0300 Anssi Hannula wrote:
> > 
> > 
> >>Fix comments so that they conform to kernel-doc and add/remove some
> >>blank lines.
> >>
> >>Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
> > 
> > 
> > (attachments make review/comments more trying, so this is an
> > abbreviated reply)
> 
> Sorry, I'll try to use some other client when I send the fixed patch.
> 
> >  /**
> > - * Lock the mutex and check the device has not been deleted
> > + * input_ff_safe_lock - lock the mutex and check for the ff_device struct
> > + *
> > + * Returns 0 if device still present, 1 otherwise.
> >   */
> >  static inline int input_ff_safe_lock(struct input_dev *dev)
> >  {
> > 
> > Functions that are commented with kernel-doc need all of the parameters
> > documented also, like:
> > 
> >  * @dev: the input_dev (or better description)
> > 
> > There were a few places where you had these and deleted them.  :(
> > ~~~~~~~~~~~~~~
> > 
> > (repeat for several functions...)
> > 
> 
> Ah, so if the comment is kernel-doc all parameters have to be always
> documented...

Right.

> I guess I can just remove the double ** for static functions, as I'm not
> sure it is necessary to document all the obvious parameters of those.
> 
> Or what do you think?

I think that kernel-doc is most important on non-static functions,
so it would be OK to remove the ** for the static ones.

---
~Randy

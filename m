Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270560AbUJUAwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270560AbUJUAwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270528AbUJUAwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:52:53 -0400
Received: from ozlabs.org ([203.10.76.45]:17613 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270669AbUJUAwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:52:13 -0400
Subject: Re: [PATCH] Remove MODULE_PARM from i386 defconfig.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <s5h6555iqf6.wl@alsa2.suse.de>
References: <1098258609.10571.145.camel@localhost.localdomain>
	 <s5h6555iqf6.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1098319932.10571.157.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 10:52:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 21:23, Takashi Iwai wrote:
> Hi Rusty,
> 
> At Wed, 20 Oct 2004 17:50:09 +1000,
> Rusty Russell wrote:
> > @@ -749,8 +749,8 @@ static int parport_nr[LP_NO] = { [0 ... 
> >  static char *parport[LP_NO] = { NULL,  };
> >  static int reset = 0;
> >  
> > -MODULE_PARM(parport, "1-" __MODULE_STRING(LP_NO) "s");
> > -MODULE_PARM(reset, "i");
> > +module_param_array(parport, charp, NULL, 0);
> 
> Can module_param_array() now take NULL for the third argument?

Yes, it was looking at the ALSA code in particular that I decided we
needed this, and hence the change.  My patch cleans most of those up, I
think.

Thanks!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell


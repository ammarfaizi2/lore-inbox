Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbUATJUO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 04:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbUATJUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 04:20:14 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:13267 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265280AbUATJUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 04:20:10 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 20 Jan 2004 10:30:54 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l-05 add infrared remote support
Message-ID: <20040120093054.GC18096@bytesex.org>
References: <20040115115611.GA16266@bytesex.org> <20040120020710.8F8F62C280@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120020710.8F8F62C280@lists.samba.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 12:55:39PM +1100, Rusty Russell wrote:
> In message <20040115115611.GA16266@bytesex.org> you write:
> > +static int repeat = 1;
> > +MODULE_PARM(repeat,"i");
> > +MODULE_PARM_DESC(repeat,"auto-repeat for IR keys (default: on)");
> > +
> > +static int debug = 0;    /* debug level (0,1,2) */
> > +MODULE_PARM(debug,"i");
> 
> Please replace the MODULE_PARM lines with the modern form:
> 
> 	module_param(repeat, bool, 0644);
> 	module_param(debug, int, 0644);

No.  The code in question must also build on 2.4 kernels which don't
have module_param().  And I don't want to clutter up the code with
#ifdefs unless I absolutely have to.

I'll do for the bttv ir support, that is 2.6 only anyway due to the
usage of tasklets.

  Gerd

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins

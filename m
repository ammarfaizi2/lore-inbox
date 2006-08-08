Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWHHJov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWHHJov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWHHJov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:44:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:4820 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932180AbWHHJou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:44:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=exIUjN31gcL2F+MfrDXrhAWdaj5zVXw1QiPzWZ6sYoXNTT0/chHZ7lb17S012s9wxXI9sqUfZQkl061LXEDaQ09GKKUJWImaKKWFImcrK4XTpO75ds+1/QI93wY7y5HsJGIkEa/rw0bFIeWx2JYwsHzYCnkfhJ9KJPpE6c3dzek=
Message-ID: <41840b750608080244hd6db6c4va4592dbaf7839263@mail.gmail.com>
Date: Tue, 8 Aug 2006 12:44:49 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Cc: "Pavel Machek" <pavel@suse.cz>, "Robert Love" <rlove@rlove.org>,
       "Jean Delvare" <khali@linux-fr.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060807232330.GA16540@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492242899-git-send-email-multinymous@gmail.com>
	 <20060807134440.GD4032@ucw.cz>
	 <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com>
	 <20060807231557.GA2759@elf.ucw.cz> <20060807232330.GA16540@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Greg KH <gregkh@suse.de> wrote:
> > > >> +module_param_named(debug, tp_debug, int, 0600);
> > > >> +MODULE_PARM_DESC(debug, "Debug level (0=off, 1=on)");
> > > >> +
> > > >> +/* A few macros for printk()ing: */
> > > >> +#define DPRINTK(fmt, args...) \
> > > >> +  do { if (tp_debug) printk(KERN_DEBUG fmt, ## args); } while (0)
> > > >
> > > >Is not there generic function doing this?
> > >
> > > None that I found. Many drivers do it this way.
> >
> > linux/kernel.h : pr_debug() looks similar.
>
> Use dev_dbg() and friends please instead of rolling your own.

But both pr_debug() and dev_dbg() do a static "#ifdef DEBUG", not a
runtime check of the 'debug' module paraeter.

Anyway, it turns out I don't really have any interesting debug outputs
anymore, so I'm eliminating DPRINTK() and the 'debug' module
parameter.

I'm still rolling my own printk formatting macro because thinkpad_ec
doesn't have a device for dev_dbg().

  Shem

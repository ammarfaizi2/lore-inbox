Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263194AbTC1XJN>; Fri, 28 Mar 2003 18:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263198AbTC1XJN>; Fri, 28 Mar 2003 18:09:13 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:4879 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S263194AbTC1XJM>;
	Fri, 28 Mar 2003 18:09:12 -0500
Date: Sat, 29 Mar 2003 00:20:22 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       aeb@cwi.nl
Subject: Re: NICs trading places ?
Message-ID: <20030328232022.GA12005@win.tue.nl>
References: <20030328221037.GB25846@suse.de> <20030328224843.GA11980@win.tue.nl> <20030328150234.7f73d916.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328150234.7f73d916.akpm@digeo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 03:02:34PM -0800, Andrew Morton wrote:
> Andries Brouwer <aebr@win.tue.nl> wrote:
>
> > +	if (retval == 0) {
> > +		int i;
> > +		printk("%s: 3c59x, address", dev->name);
> > +		for (i = 0; i < 6; i++)
> > +			printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
> > +		printk("\n");
> >  		return 0;
> > +	}
> 
> hm.  typing `ifconfig' shows this information.

I like uniformity.
Either all eth cards should have their address in dmesg, or none.
Almost all do.

And: ifconfig does not give the card types.
So presently one needs both boot messages and ifconfig.

And: in some situations the system does not boot because of
eth numbering mixup, and one never gets the opportunity to
ask ifconfig.

Andries


Return-Path: <linux-kernel-owner+w=401wt.eu-S1753456AbXABMp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbXABMp6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbXABMp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:45:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1468 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753456AbXABMp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:45:57 -0500
Date: Tue, 2 Jan 2007 13:45:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Miller <davem@davemloft.net>
Cc: samuel@sortiz.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/irda/: proper prototypes
Message-ID: <20070102124557.GQ20714@stusta.de>
References: <20061218034626.GY10316@stusta.de> <20070102.003953.21925510.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102.003953.21925510.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 12:39:53AM -0800, David Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Mon, 18 Dec 2006 04:46:26 +0100
> 
> > This patch adds proper prototypes for some functions in
> > include/net/irda/irda.h
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
>  ...
> > +struct net_device;
> > +struct packet_type;
> > +
> > +void irda_proc_register(void);
> > +void irda_proc_unregister(void);
> > +
> > +int irda_sysctl_register(void);
> > +void irda_sysctl_unregister(void);
> > +
> > +int irsock_init(void);
> > +void irsock_cleanup(void);
> > +
> > +int irlap_driver_rcv(struct sk_buff *skb, struct net_device *dev,
> > +		     struct packet_type *ptype, struct net_device *orig_dev);
> 
> Remind me why you remove the "extern" from "external" function
> declarations all the time?

It's shorter, letting more contents fit into one line.

> I don't like it, even if it's "correct", because it is inconsistent
> with what we do in the entire rest of the networking code.

Good point.

Is it OK to slowly starting converting them or do you want them to stay?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


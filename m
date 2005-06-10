Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVFJHSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVFJHSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVFJHSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:18:10 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:3016 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262506AbVFJHSG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:18:06 -0400
Date: Fri, 10 Jun 2005 09:08:27 +0200 (CEST)
To: greg@kroah.com
Subject: Re: BUG in i2c_detach_client
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <nAod2h83.1118387307.3144940.khali@localhost>
In-Reply-To: <20050610055854.GB15873@kroah.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Andrew James Wade" 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

> > --- linux-2.6.12-rc6/drivers/i2c/chips/asb100.c.orig
> > +++ linux-2.6.12-rc6/drivers/i2c/chips/asb100.c
> > @@ -859,6 +859,7 @@
> >  	return 0;
> >
> >  ERROR3:
> > +	i2c_detach_client(data->lm75[1]);
> >  	i2c_detach_client(data->lm75[0]);
> >  	kfree(data->lm75[1]);
> >  	kfree(data->lm75[0]);
>
> Hm, what tree is this against?  Am I missing some inbetween patch here?

2.6.12-rc6-mm1, but that was a fix to Mark's hwmon patches, which you
just backed out from your tree - so this fix is no more needed (and
should unsurprisingly fail to apply).

Thanks,
--
Jean Delvare

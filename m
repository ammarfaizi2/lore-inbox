Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUAONwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 08:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUAONwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 08:52:38 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:19126 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265051AbUAONwh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 08:52:37 -0500
Subject: Re: [Newbie-warning] MOD_INC_USE_COUNT usage
From: "Yury V. Umanets" <umka@namesys.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Tim Cambrant <tim@cambrant.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m37jzuv14v.fsf@defiant.pm.waw.pl>
References: <20040114172022.GA2112@cambrant.com>
	 <m37jzuv14v.fsf@defiant.pm.waw.pl>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1074174817.1837.151.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 15 Jan 2004 16:53:37 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-14 at 21:25, Krzysztof Halasa wrote:
> Tim Cambrant <tim@cambrant.com> writes:
> 
> > So, why shouldn't this patch be applied?:
> >
> > --- drivers/ide/pci/generic.c.orig      2004-01-14 17:52:35.000000000 +0100
> > +++ drivers/ide/pci/generic.c   2003-11-24 13:54:01.000000000 +0100
> > @@ -121,6 +121,7 @@ static int __devinit generic_init_one(st
> > 		return 1;
> > 	}
> > 	ide_setup_pci_device(dev, d);
> > +	MOD_INC_USE_COUNT;
> > 	return 0;
> >  }
> 
> It isn't that easy - the module must be marked as being in use this
> way or (preferably) another.

Hello,

As I can see, this is really redundant to have a MOD_INC_USE_COUNT for
almost all the modules. But this should be checked carefully before
removing ;)


-- 
umka


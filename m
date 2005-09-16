Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbVIPEal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbVIPEal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 00:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbVIPEal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 00:30:41 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:56435 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030593AbVIPEak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 00:30:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 16/28] drivers/usb/input: convert to dynamic input_dev allocation
Date: Thu, 15 Sep 2005 23:30:25 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, kay.sievers@vrfy.org,
       vojtech@suse.cz, hare@suse.de
References: <20050915070131.813650000.dtor_core@ameritech.net> <200509152259.35027.dtor_core@ameritech.net> <20050915211805.11dc1726.akpm@osdl.org>
In-Reply-To: <20050915211805.11dc1726.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509152330.26789.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 September 2005 23:18, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> > On Thursday 15 September 2005 22:53, Andrew Morton wrote:
> > > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > >
> > > >  Input: convert drivers/iusb/input to dynamic input_dev allocation
> > > 
> > > The absfuzz initialisation in kbtab_probe() got lost.
> > > 
> > 
> > Looks fine here:
> > 
> > +       input_set_abs_params(input_dev, ABS_X, 0, 0x2000, 4, 0);
> > +       input_set_abs_params(input_dev, ABS_X, 0, 0x1750, 4, 0);
> >                                                          ^^^
> 
> Oh.  You mean they replace these?
> 
> -	kbtab->dev.absfuzz[ABS_X] = 4;
> -	kbtab->dev.absfuzz[ABS_Y] = 4;
> 
> Not a step forward in readability?
>

Depends... It's much more compact so quite often you can see entire
device specification on one screen which is nice IMHO. Just remeber
"min, max, fuzz, flat" ;)

-- 
Dmitry

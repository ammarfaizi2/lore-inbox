Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWIUDCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWIUDCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 23:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWIUDCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 23:02:34 -0400
Received: from web36704.mail.mud.yahoo.com ([209.191.85.38]:859 "HELO
	web36704.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751141AbWIUDCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 23:02:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0DJbc4Neprwj0yXVCMOHc5gDtEfet5Rw2xM237rRa9OdTp2eRaN198j7h0noXCROb1RbF6+4aEa9b0JxwO2uxyussJ/C+Sy5JbFa6x9t9KwXrzIP/8s3cEV2Uya+DWtxSeV0Xw+KD61UJkZXNI1SKKA0aX3VzPrKR41kSi64RFo=  ;
Message-ID: <20060921030232.30990.qmail@web36704.mail.mud.yahoo.com>
Date: Wed, 20 Sep 2006 20:02:32 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [PATCH 2/2] [MMC] Driver for TI FlashMedia card reader - Kconfig/Makefile entries
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
In-Reply-To: <4510E00C.4040703@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  
> > +comment "Texas Instruments Flash Media MMC/SD interface requires TIFM_CORE"
> > +        depends on MMC != n && TIFM_CORE = n
> > +	
> > +config MMC_TIFM_SD
> > +	tristate "TI Flash Media MMC/SD Interface support  (EXPERIMENTAL)"
> > +	depends on TIFM_CORE && MMC && EXPERIMENTAL
> > +	default TIFM_CORE
> > +	help
> > +	  This selects the Texas Instruments(R) Flash Media MMC/SD card
> > +	  interface found in many laptops.
> > +	  If you have a controller with this interface, say Y or M here.
> > +
> > +	  If unsure, say N.
> > +
> >   
> 
> Ditto. And until this depends/select business is sorted out, I'd prefer
> a select on TIFM_CORE here.
> 
I kind of fail to follow here. Do you want to switch TIFM_CORE -> MMC_TIFM_SD dependency into
MMC_TIFM_SD -> TIFM_CORE + TIFM_7XX1 one? It may be slightly more convenient for users (even
though most are using pre-compiled kernels provided by distribution), but will be logically
incorrect, doesn't it? And then, what will become of memorystick driver?


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

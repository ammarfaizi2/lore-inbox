Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030556AbWBAG5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556AbWBAG5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 01:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030557AbWBAG5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 01:57:34 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56811 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1030555AbWBAG5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 01:57:33 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rc1-mm4: ACX=y, ACX_USB=n compile error
Date: Wed, 1 Feb 2006 08:57:04 +0200
User-Agent: KMail/1.8.2
Cc: "John W. Linville" <linville@tuxdriver.com>,
       "Gabriel C." <crazy@pimpmylinux.org>, da.crew@gmx.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060130133833.7b7a3f8e@zwerg> <200601311658.09423.vda@ilport.com.ua> <20060131221637.GJ3986@stusta.de>
In-Reply-To: <20060131221637.GJ3986@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602010857.04964.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 00:16, Adrian Bunk wrote:
> > > > CONFIG_ACX=y
> > > > # CONFIG_ACX_PCI is not set
> > > > # CONFIG_ACX_USB is not set
> > > > 
> > > > This won't fly. You must select at least one.
> > > > 
> > > > Attached patch will check for this and #error out.
> > > > Andrew, do not apply to -mm, I'll send you bigger update today.
> > > 
> > > Is there any way to move this into a Kconfig file?  That seems nicer
> > > than having #ifdefs in source code to check for a configuration error.
> > 
> > Can't think of any at the moment.
> 
> There are two possible solutions ("offer" means "is user visible"):
> - only offer ACX and always build ACX_PCI/ACX_USB depending on the
>   availability of PCI/USB
> - only offer ACX_PCI and ACX_USB which select ACX
> 
> If you tell me which you prefer I can send a patch.

Second one sounds okay to me.
--
vda

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289842AbSAWNBF>; Wed, 23 Jan 2002 08:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289840AbSAWNAz>; Wed, 23 Jan 2002 08:00:55 -0500
Received: from ns.suse.de ([213.95.15.193]:25363 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289839AbSAWNAr>;
	Wed, 23 Jan 2002 08:00:47 -0500
Date: Wed, 23 Jan 2002 14:00:44 +0100
From: Dave Jones <davej@suse.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre3 -- aironet4500_core.c:2839:  In function `awc_init': incompatible types in return
Message-ID: <20020123140044.E31032@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1011771248.24309.60.camel@stomata.megapathdsl.net> <20020123104550.16b160b0.johnpol@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020123104550.16b160b0.johnpol@2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Wed, Jan 23, 2002 at 10:45:50AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 10:45:50AM +0300, Evgeniy Polyakov wrote:
 > --- ./drivers/net/aironet4500_core.c~   Sun Sep 30 23:26:06 2001
 > +++ ./drivers/net/aironet4500_core.c    Wed Jan 23 10:44:03 2002
 > @@ -2836,7 +2836,7 @@
 >         return 0; 
 >     final:
 >         printk(KERN_ERR "aironet init failed \n");
 > -       return NODEV;
 > +       return -1;

 This should probably be return -ENODEV

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

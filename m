Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbREQTVA>; Thu, 17 May 2001 15:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261513AbREQTUu>; Thu, 17 May 2001 15:20:50 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:13281 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S261515AbREQTUk>; Thu, 17 May 2001 15:20:40 -0400
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE2AB@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'jalaja devi'" <jala_74@yahoo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: RE: kernel2.2.x to kernel2.4.x
Date: Thu, 17 May 2001 12:19:27 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

see http://www.firstfloor.org/~andi/softnet/

~Randy


> -----Original Message-----
> From: jalaja devi [mailto:jala_74@yahoo.com]
> 
> How can I handle this from kernel2.2 to kernel2.4
> 
> Can I replace like this??
> 
> if (test_and_set_bit (0, (void *)&dev->tbusy)){ return
> EBUSY;} ========== with  netif_stop_queue (dev);
> 
> clear_bit ((void *)&dev->tbusy); ===== with
> netif_start_queue(dev);
> 
> Thanks
> Jalaja
> 
> --- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > I tried porting a network driver from kernel2.2.x
> > to
> > > 2.4. When i tried loading the driver, it shows the
> > > unresolved symbols for
> > > copy_to_user_ret
> > 
> > 	if(copy_to_user(...))
> > 		return -EFAULT
> > 
> > > outs
> > 
> > 	Has not gone away, your includes are wrong
> > 
> > > __bad_udelay
> > 
> > 	You are using too large a udelay use mdelay
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Auctions - buy the things you want at great prices
> http://auctions.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


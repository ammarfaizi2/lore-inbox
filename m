Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261471AbREQSUr>; Thu, 17 May 2001 14:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbREQSUh>; Thu, 17 May 2001 14:20:37 -0400
Received: from web13704.mail.yahoo.com ([216.136.175.137]:2320 "HELO
	web13704.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261471AbREQSUd>; Thu, 17 May 2001 14:20:33 -0400
Message-ID: <20010517182032.46367.qmail@web13704.mail.yahoo.com>
Date: Thu, 17 May 2001 11:20:32 -0700 (PDT)
From: jalaja devi <jala_74@yahoo.com>
Subject: Re: kernel2.2.x to kernel2.4.x
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <E150867-0004Cs-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I handle this from kernel2.2 to kernel2.4

Can I replace like this??

if (test_and_set_bit (0, (void *)&dev->tbusy)){ return
EBUSY;} ========== with  netif_stop_queue (dev);

clear_bit ((void *)&dev->tbusy); ===== with
netif_start_queue(dev);

Thanks
Jalaja

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > I tried porting a network driver from kernel2.2.x
> to
> > 2.4. When i tried loading the driver, it shows the
> > unresolved symbols for
> > copy_to_user_ret
> 
> 	if(copy_to_user(...))
> 		return -EFAULT
> 
> > outs
> 
> 	Has not gone away, your includes are wrong
> 
> > __bad_udelay
> 
> 	You are using too large a udelay use mdelay
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/

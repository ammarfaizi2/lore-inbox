Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268842AbRHFQPI>; Mon, 6 Aug 2001 12:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268849AbRHFQO6>; Mon, 6 Aug 2001 12:14:58 -0400
Received: from customers.imt.ru ([212.16.0.33]:20030 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S268842AbRHFQOv>;
	Mon, 6 Aug 2001 12:14:51 -0400
Message-ID: <20010806091022.A32579@saw.sw.com.sg>
Date: Mon, 6 Aug 2001 09:10:22 -0700
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: eepro100.c - Add option to disable power saving in 2.4.7-ac7
In-Reply-To: <3B6EBC34.9578EA4E@TeraPort.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <3B6EBC34.9578EA4E@TeraPort.de>; from "Martin Knoblauch" on Mon, Aug 06, 2001 at 05:48:04PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Making it an option looks like a reasonable idea.
However, could you mind the indentation style of the driver, please?

On Mon, Aug 06, 2001 at 05:48:04PM +0200, Martin Knoblauch wrote:
>  after realizing that my first attempt for this patch was to
> enthusiastic, I have no a somewhat stripped down version. Compiles
> against 2.4.7-ac7.
> 
>  The patch adds the option "power_save" to eepro100. If "1" (default),
> power save handling is done as normal. If "0", no power saving is done.
> This is to workaround some flaky eepro100 adapters that do not survive
> D0->D2-D0 transitions.
[snip]
> @@ -1833,7 +1842,8 @@
>  	if (speedo_debug > 0)
>  		printk(KERN_DEBUG "%s: %d multicast blocks dropped.\n", dev->name, i);
>  
> -	pci_set_power_state(sp->pdev, 2);
> +	if (power_save)
> +	  pci_set_power_state(sp->pdev, 2);
>  
>  	MOD_DEC_USE_COUNT;
>  

Best regards
		Andrey

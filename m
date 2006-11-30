Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759167AbWK3Ir2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759167AbWK3Ir2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759168AbWK3Ir2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:47:28 -0500
Received: from mx0.towertech.it ([213.215.222.73]:54245 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1759164AbWK3Ir1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:47:27 -0500
Date: Thu, 30 Nov 2006 09:47:23 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: tr@newtec.dk
Cc: a.zummo@towertech.it, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1743 support
Message-ID: <20061130094723.6ab9e1d3@inspiron>
In-Reply-To: <200611300812.02261.tr@newtec.dk>
References: <200611300812.02261.tr@newtec.dk>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 08:12:02 +0100
Torsten Ertbjerg Rasmussen <tr@newtec.dk> wrote:

> The real time clocks ds1742 and ds1743 differs only in the size of the nvram. 
> This patch changes the existing ds1742 driver to support also ds1743. The 
> main change is that the nvram size is determined from the resource attached 
> to the device. 


> +	pdata->ioaddr_rtc = ioaddr + pdata->size_nvram;
>  
>  	/* turn RTC on if it was not on */
> +	ioaddr = pdata->ioaddr_rtc;
>  	sec = readb(ioaddr + RTC_SECONDS);

 why not
	sec = readb(pdata->ioaddr_rtc + RTC_SECONDS);
?


 Acked-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWFYJ4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWFYJ4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 05:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWFYJ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 05:56:16 -0400
Received: from mx0.towertech.it ([213.215.222.73]:19401 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932213AbWFYJ4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 05:56:16 -0400
Date: Sun, 25 Jun 2006 11:55:25 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] RTC: add rtc-ds1553 and rtc-ds1742 driver
Message-ID: <20060625115525.098f53a5@inspiron>
In-Reply-To: <20060623.182828.92343173.nemoto@toshiba-tops.co.jp>
References: <20060623.001927.74750182.anemo@mba.ocn.ne.jp>
	<20060623001622.65db7c0f@inspiron>
	<20060623.182828.92343173.nemoto@toshiba-tops.co.jp>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 18:28:28 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> > > +static int ds1553_rtc_ioctl(struct device *dev, unsigned int cmd,
> > > +			    unsigned long arg)
> > > +{
> > > +	struct platform_device *pdev = to_platform_device(dev);
> > > +	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> > > +
> > > +	if (pdata->irq < 0)
> > > +		return -ENOIOCTLCMD;
> > 
> >  inappropriate -Exxx . maybe -ENODEV?.
> 
> No, it is intentional.  If irq is not available, I want to fall back
> into emulation in rtc-dev.c.

 maybe you can add a comment explaining this choice

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


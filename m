Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWIUJXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWIUJXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 05:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWIUJXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 05:23:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:17738 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750973AbWIUJXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 05:23:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nxbxcBJuAloDCdxQeLd1oMTEA0pwaaQuWY8lidcQmx/AKZ1znEaZxls82USgk0uUMkNM3LGTBMBDZGLegahNk72vv6DNie2Nvh6ouHOasXPDehNmyifx5FQbbeDIxx8EqNeHQ4hfuEYoEki1xvERQn4kzexFgipC/YrgQ66iLm8=
Message-ID: <6d6a94c50609210223o5adf9bb5w7bfb70fb59094c85@mail.gmail.com>
Date: Thu, 21 Sep 2006 17:23:52 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1158830784.11109.93.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
	 <1158830784.11109.93.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Iau, 2006-09-21 am 11:33 +0800, ysgrifennodd Luke Yang:
> > Hi,
> >
> > This is the serial driver for Blackfin. It is designed for the serial
> > core framework.
>
> > +#define DMA_RX_XCOUNT                TTY_FLIPBUF_SIZE
>
> TTY_FLIPBUF_SIZE is going away. Just pick a value good for your hardware
> and under PAGE_SIZE.

Thanks for your comments. I'll change it soon and submit a new patch.

>
> Other question - is your locking ok for low latency. In low latency mode
> tty_flip_buffer_push() may directly end up calling your write methods.
>
Yes, I noticed that and I think it's ok. The driver is tested everday
and works fine.

-Aubrey

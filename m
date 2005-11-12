Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbVKLWGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVKLWGT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVKLWGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:06:19 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:23971 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964836AbVKLWGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:06:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=n4Iyb6zPrQhbFDPcoh5h4nTZ91B7CtdN1yctdp2RoD4DdOaOQgRI9C0mvNOMaLpgHakcgCdKs9U9MxxH1YhjuDSSCvqGuC930ShWWPRqDrPmb0wJpVA9nBFGItouYeZD3SMZJSJEm/+FN4W8v8JKribJYF4KP4Ihxr3vO/MoQD0=
Date: Sun, 13 Nov 2005 01:19:55 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Gabriel A. Devenyi" <ace@staticwave.ca>
Cc: markus.lidel@shadowconnect.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/message/i2o/i2o_block.c unsigned comparison
Message-ID: <20051112221955.GF20860@mipter.zuzino.mipt.ru>
References: <200511121629.54699.ace@staticwave.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511121629.54699.ace@staticwave.ca>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 04:29:54PM -0500, Gabriel A. Devenyi wrote:
> --- a/drivers/message/i2o/i2o_block.c
> +++ b/drivers/message/i2o/i2o_block.c

>  static int i2o_block_ioctl(struct inode *inode, struct file *file,
> -			   unsigned int cmd, unsigned long arg)
> +			   unsigned int cmd, long arg)
>  {

Don't you see this?

  CC      drivers/message/i2o/i2o_block.o
drivers/message/i2o/i2o_block.c:961: warning: initialization from incompatible pointer type

->ioctl method takes "unsigned long arg".


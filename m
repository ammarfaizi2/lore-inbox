Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVJFO1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVJFO1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVJFO1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:27:39 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:61979 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751007AbVJFO1i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:27:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cTYkYYqQPQ+oIvhVKg+SkC/bmU2hoqSy3fURcH57TXRr/lnHo9fML7m5d0SX7EbBP3KM+WrWR1/qHWdXQY34xQhGaXTJGw4AtBlHZd9mjAMrGu7hfsX//jzcLZEyU2se4jRs2svx+KyIk/7udFHfF/zaPWASb6sn/8TvHOUpqiA=
Message-ID: <81b0412b0510060727h35c0fd78i260037ca89f253f9@mail.gmail.com>
Date: Thu, 6 Oct 2005 16:27:37 +0200
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: madhu.subbaiah@wipro.com
Subject: Re: select(0,NULL,NULL,NULL,&t1) used for delay
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128606546.14385.26.camel@penguin.madhu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1128606546.14385.26.camel@penguin.madhu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Madhu K.S. <madhu.subbaiah@wipro.com> wrote:
> Hi all,
>
> In many application we use select() system call for delay.
>
> example:
> select(0,NULL,NULL,NULL,&t1);
>
> select() for delay is very inefficient. I modified sys_select() code for

Why don't you just use nanosleep(2) (or usleep)?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVFVUHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVFVUHI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVFVUHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:07:04 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:8338 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262000AbVFVUEf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:04:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cr4NDtaoNrN8f03kzWJ9MMr+WhvR/c0LSoOKUdh7oyX4bB3VVsH6HS3Vg7oq74IIpvxzW0gyKYnh4IRZkUgmlV99hNBHyvR3wwsW43zpJYmhSRcdmeAA7spI9X8R2gzWMrubtluTvGImwpG8p1MT95CCGBAko3aEEfZQg3ntf54=
Message-ID: <84144f02050622130424379bf3@mail.gmail.com>
Date: Wed, 22 Jun 2005 23:04:33 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/05, Bouchard, Sebastien <Sebastien.Bouchard@ca.kontron.com> wrote:
> +static int __init
> +tlclk_init(void)
> +{

[snip]

> +       if (check_region(TLCLK_BASE, 8)) {
> +               printk(KERN_ERR
> +                      "telclock: I/O region already used by another
> driver!\n");
> +               return -EBUSY;
> +       } else {
> +               request_region(TLCLK_BASE, 8, "telclock");

request_region can fail too so you'd better handle that.

                               Pekka

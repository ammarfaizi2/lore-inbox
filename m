Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWJBShn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWJBShn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWJBShn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:37:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:28639 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964775AbWJBShm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:37:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BDzwTZPseAewUqFGo5jCCI/Az4iwej0xJX2D5ysScXvcYxVITjy6+ryudsx1TNLBr32mvCJcZX+4nobrsm2LZUyAILu1o/KdvHhe5LpEx9q4rtg5qXVHudpwOlwzVz2YYp6wYjC/mjbSzcSGwo5etTMddu5sdOp2tI1eeqTeVXE=
Message-ID: <82ecf08e0610021137r446031a8pa303053479e9cb27@mail.gmail.com>
Date: Mon, 2 Oct 2006 14:37:39 -0400
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch 2.6.18-git] SPI -- Freescale iMX SPI controller driver
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Andrea Paterniani" <a.paterniani@swapp-eng.it>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200610020816.58985.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610020816.58985.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<nitpickery on>
+
> +/*-------------------------------------------------------------------------*/
> +/* SPI Control Register Bit Fields & Masks */
> +#define SPI_CONTROL_BITCOUNT   (0xF)           /* Bit Count Mask */
> +#define SPI_CONTROL_BITCOUNT_1 (0x0)           /* Bit Count = 1 */
> +#define SPI_CONTROL_BITCOUNT_2 (0x1)           /* Bit Count = 2 */
> +#define SPI_CONTROL_BITCOUNT_3 (0x2)           /* Bit Count = 3 */

I thinking these comments are awfully confusing (bitcount_1 == 0
?!?!?) and maybe redundant.

It would be much more useful to explain the logic behind why
(bitcount_1 == 0) and remove the /* Bit Count = X */ comments


> +/* SPI Soft Reset Register Bit Fields & Masks */
> +#define SPI_RESET_START                (0x1 << 0)      /* Start */

Wouldn't only (0x1) be better?

> +
> +/* Message state */
> +#define START_STATE                    ((void*)0)
> +#define RUNNING_STATE                  ((void*)1)
> +#define DONE_STATE                     ((void*)2)
> +#define ERROR_STATE                    ((void*)-1)

!?!??!?!

All in all, except for what Andrew has pointed out, it looks good,
maybe a little bit overengineered...

-- 
-
Thiago Galesi

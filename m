Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWIZVRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWIZVRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWIZVRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:17:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:13757 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932417AbWIZVRa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:17:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VXz1EtDog4I6Cv2/W9ktvrHyFAptgeSed5tpM3jnMkc6bMxPwUqiionEFtuvrxFC/iUjzyUkAUPqXUXy7fyuKhTK2Hj0ixjw2fyVX18aVeOJ3HIEj259dc4ELBcT350+7X/gAy/lFfR6RjRtIV/lK0bovYIfCZFzZzWpr7Rnk7I=
Message-ID: <1defaf580609261417v4d3ea0f3pb10699d60ad0323f@mail.gmail.com>
Date: Tue, 26 Sep 2006 23:17:29 +0200
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [PATCH] avr32 architecture
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "=?ISO-8859-1?Q?H=E5vard_Skinnemoen?=" <hskinnemoen@atmel.com>,
       akpm@osdl.org
In-Reply-To: <1159304576.3309.54.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200609261601.k8QG1Txd005700@hera.kernel.org>
	 <1159304576.3309.54.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2006-09-26 at 16:01 +0000, Linux Kernel Mailing List wrote:
> > [PATCH] avr32 architecture
>
> pmac /pmac/git/linux-2.6 $ make ARCH=avr32 headers_check
>   CHK     include/linux/version.h
> make[1]: `scripts/unifdef' is up to date.
>   CHECK   include/asm/user.h
>   CHECK   include/asm/unistd.h
> /pmac/git/linux-2.6/usr/include/asm/unistd.h requires linux/linkage.h, which does not exist in exported headers

Right. avr32-implement-kernel_execve.patch, which was flagged as "Will
merge" by Andrew, fixes it by moving the #ifdef __KERNEL__ guard to
cover everything but the __NR_foo definitions. So as long as that
one's still scheduled for inclusion, I think sending a separate patch
to fix this problem will do more harm than good.

But thanks for testing :)

Håvard

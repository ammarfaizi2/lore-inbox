Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289313AbSAVOKC>; Tue, 22 Jan 2002 09:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289312AbSAVOJx>; Tue, 22 Jan 2002 09:09:53 -0500
Received: from mail2.infineon.com ([192.35.17.230]:40698 "EHLO
	mail2.infineon.com") by vger.kernel.org with ESMTP
	id <S289314AbSAVOJi>; Tue, 22 Jan 2002 09:09:38 -0500
X-Envelope-Sender-Is: Erez.Doron@savan.com (at relayer mail2.infineon.com)
Subject: solved: ( was Re: non volatile ram disk)
From: Erez Doron <erez@savan.com>
To: linux kernel <linux-kernel@vger.kernel.org>, ilug <linux-il@linux.org.il>
In-Reply-To: <1011618928.2825.5.camel@hal.savan.com>
In-Reply-To: <1011618928.2825.5.camel@hal.savan.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 22 Jan 2002 15:53:45 +0200
Message-Id: <1011707625.1835.3.camel@hal.savan.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, i finanly managed to make a ramdisk which will not earsed by
reboot.

the solution is to give mem=32m, and use ioremap to map the rest of the
32m to virtual adresses

now it works !!!

thanks anyway
erez.



On Mon, 2002-01-21 at 15:15, Erez Doron wrote:
> hi
> 
> I'm looking for a way to make a ramdisk which is not erased on reboot
> this is for use with ipaq/linux.
> 
> i tought of booting with mem=32m and map a block device to the rest of
> the 32M ram i have.
> 
> the probelm is that giving mem=32m to the kernel will cause the kernel
> to map only the first 32m of physical memory to virtual one, so using
> __pa(ptr) on the top 32m causes a kernel oops.
> 
> any idea ?
> 
> 
> regards
> erez.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


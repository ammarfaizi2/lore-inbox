Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290662AbSA3WRx>; Wed, 30 Jan 2002 17:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290668AbSA3WQY>; Wed, 30 Jan 2002 17:16:24 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:40590 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S290656AbSA3WP6>; Wed, 30 Jan 2002 17:15:58 -0500
Message-ID: <3C58709C.1030908@nyc.rr.com>
Date: Wed, 30 Jan 2002 17:15:56 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 Link Error
In-Reply-To: <fa.c3ed77v.1cnie03@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber wrote:

>         -o vmlinux
> fs/fs.o: In function `cap_info_llseek':
> fs/fs.o(.text+0x4e1d1): undefined reference to `lock_kernel'
> fs/fs.o(.text+0x4e220): undefined reference to `unlock_kernel'
> fs/fs.o: In function `hdr_llseek':
> fs/fs.o(.text+0x4e858): undefined reference to `lock_kernel'
> fs/fs.o(.text+0x4e8b6): undefined reference to `unlock_kernel'
> make: *** [vmlinux] Error 1
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I think this has something to do with <linux/smp_lock.h> not
being included somewhere in the HFS filesystem headers.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267160AbUBSAJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUBSAJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:09:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56507 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267160AbUBSAJd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:09:33 -0500
Message-ID: <4033FEAA.1070704@pobox.com>
Date: Wed, 18 Feb 2004 19:09:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Andrew Morton <akpm@osdl.org>, linux@syskonnect.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1-mm2: warning in drivers/net/sk98lin/skge.c
References: <20040105002056.43f423b1.akpm@osdl.org> <20040106181318.GH11523@fs.tum.de> <20040106102009.4e058f51.akpm@osdl.org> <20040208131413.GP7388@fs.tum.de>
In-Reply-To: <20040208131413.GP7388@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Jan 06, 2004 at 10:20:09AM -0800, Andrew Morton wrote:
> 
>>Adrian Bunk <bunk@fs.tum.de> wrote:
>>
>>>drivers/net/sk98lin/skge.c: In function `skge_probe':
>>>drivers/net/sk98lin/skge.c:713: warning: unused variable `proc_root_initialized'
>>
>>hm, I thought I sent Jeff a fix for that.
>>
>>Yes, the definition should just be deleted.
> 
> 
> This warning is still present in 2.6.2-mm1 and 2.6.3-rc1.
> 
> Please apply the following patch:
> 
> --- linux-2.6.2-mm1/drivers/net/sk98lin/skge.c.old	2004-02-08 14:11:48.000000000 +0100
> +++ linux-2.6.2-mm1/drivers/net/sk98lin/skge.c	2004-02-08 14:11:57.000000000 +0100
> @@ -294,7 +294,6 @@
>  	SK_BOOL BootStringCount = SK_FALSE;
>  	int			retval;
>  #ifdef CONFIG_PROC_FS
> -	int			proc_root_initialized = 0;
>  	struct proc_dir_entry	*pProcFile;
>  #endif


This just went in, via SysKonnect.

So you and akpm may cheer :)

	Jeff




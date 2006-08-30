Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWH3FGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWH3FGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 01:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWH3FGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 01:06:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:54426 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965011AbWH3FGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 01:06:06 -0400
Message-ID: <44F51CB7.4010504@cn.ibm.com>
Date: Wed, 30 Aug 2006 13:05:59 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walkinair@cn.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: walkinair@cn.ibm.com
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, havelblue@us.ibm.com
Subject: Re: Swap file or device can't be recognized by kernel built with
 64K pages.
References: <44F50940.1010204@cn.ibm.com>
In-Reply-To: <44F50940.1010204@cn.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yao Fei Zhu wrote:

> Problem description:
> swap file or device can't be recognized by kernel built with 64K pages.
>
> Hardware Environment:
>    Machine type (p650, x235, SF2, etc.): B70+
>    Cpu type (Power4, Power5, IA-64, etc.): POWER5+
> Software Environment:
>    OS : SLES10 GMC
>    Kernel: 2.6.18-rc5
> Additional info:
>
> tc1:~ # uname -r
> 2.6.18-rc5-ppc64
>
> tc1:~ # zcat /proc/config.gz | grep 64K
> CONFIG_PPC_64K_PAGES=y
>
> tc1:~ # mkswap ./swap.file
> Assuming pages of size 65536 (not 4096)
> Setting up swapspace version 0, size = 4294901 kB

Should use mkswap -v1 to create a new style swap area.

>
> tc1:~ # swapon ./swap.file
> swapon: ./swap.file: Invalid argument
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



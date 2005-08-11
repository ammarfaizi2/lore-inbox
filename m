Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbVHKLQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbVHKLQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbVHKLQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:16:20 -0400
Received: from [195.23.16.24] ([195.23.16.24]:25014 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S1030271AbVHKLQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:16:20 -0400
Message-ID: <42FB3381.3010809@grupopie.com>
Date: Thu, 11 Aug 2005 12:16:17 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: kai.germaschewski@gmx.de, kai@germaschewski.name,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] do not save thousands of useless symbols in KALLSYMS
 kernels
References: <200508111403.39708.vda@ilport.com.ua>
In-Reply-To: <200508111403.39708.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Sample of my kernel's mostly useless symbols
> (starting_with:# of symbols):
> 
> __func__: 624
> __vendorstr_: 1760
> __pci_fixup_PCI_: 116
> __ksymtab_: 2597
> __kstrtab_: 2597
> __kcrctab_: 2597
> __initcall_: 236
> __devicestr_: 4686
> __devices_: 1760
> Total: 16973
> Lines in System.map: 39735
> 
> Excluding them from in-kernel symbol table saves ~300kb:
> 
>    text    data     bss     dec     hex filename
> 4337710 1054414  259296 5651420  563bdc vmlinux.carrier1 - w/o KALLSYMS
> 4342068 1296046  259296 5897410  59fcc2 vmlinux - with KALLSYMS+patch
> 4341948 1607634  259296 6208878  5ebd6e vmlinux.carrier - with KALLSYMS
>         ^^^^^^^

Hummm.... these symbols should only go in if you config KALLSYMS_ALL. 
Are you sure your configuration doesn't have KALLSYMS_ALL enabled?

If it does, it seems like the correct behavior to include all symbols if 
you specified that you wanted _all_ symbols :)

By the way, there is a completely different version of 
scripts/kallsyms.c in -mm that you might want to look at. It will 
probably go in after 2.6.13 is out.

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams

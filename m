Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVHKLi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVHKLi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVHKLi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:38:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43161 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1030286AbVHKLi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:38:58 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [PATCH] do not save thousands of useless symbols in KALLSYMS kernels
Date: Thu, 11 Aug 2005 14:38:34 +0300
User-Agent: KMail/1.5.4
Cc: kai.germaschewski@gmx.de, kai@germaschewski.name,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <200508111403.39708.vda@ilport.com.ua> <42FB3381.3010809@grupopie.com>
In-Reply-To: <42FB3381.3010809@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111438.34620.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 August 2005 14:16, Paulo Marques wrote:
> Denis Vlasenko wrote:
> > Sample of my kernel's mostly useless symbols
> > (starting_with:# of symbols):
> > 
> > __func__: 624
> > __vendorstr_: 1760
> > __pci_fixup_PCI_: 116
> > __ksymtab_: 2597
> > __kstrtab_: 2597
> > __kcrctab_: 2597
> > __initcall_: 236
> > __devicestr_: 4686
> > __devices_: 1760
> > Total: 16973
> > Lines in System.map: 39735
> > 
> > Excluding them from in-kernel symbol table saves ~300kb:
> > 
> >    text    data     bss     dec     hex filename
> > 4337710 1054414  259296 5651420  563bdc vmlinux.carrier1 - w/o KALLSYMS
> > 4342068 1296046  259296 5897410  59fcc2 vmlinux - with KALLSYMS+patch
> > 4341948 1607634  259296 6208878  5ebd6e vmlinux.carrier - with KALLSYMS
> >         ^^^^^^^
> 
> Hummm.... these symbols should only go in if you config KALLSYMS_ALL. 
> Are you sure your configuration doesn't have KALLSYMS_ALL enabled?

Yes, it has...
--
vda


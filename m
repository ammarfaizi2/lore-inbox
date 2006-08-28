Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWH1Ija@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWH1Ija (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWH1Ija
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:39:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30425 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751294AbWH1Ij3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:39:29 -0400
Subject: Re: linux on Intel D915GOM oops
From: Arjan van de Ven <arjan@infradead.org>
To: Henti Smith <henti@geekware.co.za>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060828102149.26b05e8b@yoda.foad.za.net>
References: <20060828102149.26b05e8b@yoda.foad.za.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 28 Aug 2006 10:39:06 +0200
Message-Id: <1156754346.3034.167.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 10:21 +0200, Henti Smith wrote:
> Hi guys,
> 
> I've been given a mecer Xhibitor media center machine to try and get
> linux on for testing. 
> 
> The machine seems pretty much limited to South Africa, however the
> setup is used by other companies like
> http://www.higrade.com/nqcontent.cfm?a_id=3539 and
> http://www.alienware.com/product_detail_pages/DHS_2/dhs_2_features.aspx?SysCode=PC-DHS2&SubCode=SKU-DEFAULT
> which use the same mainboard atc. 
> 
> for more information ont he mainboard used:
> http://www.intel.com/design/motherbd/om/om_documentation.htm
> 
> I've tried to boot just about every linux distro I can get my hands on
> and they all oops at bootup. 
> 
> Unfortunately I cannot get to the first few lines (screen cannot scroll
> after oops) 
> but here is what I can get to : This is booting with Ubuntu
> 
> PREEMPT
> Modules linked in:
> CPU:	0
> EIP:	0060:[<c00f02fa>]	not tainted
> EFLAGS:	00010046	(2.6.8.1-3-386)
> EIP is at 0xc00f02fa
> eax: 49435024 ebx: 00007000 ecx: 00000000 edx: 00000010
> esi: 00000001 edi: c02cd4a4
> [<c01f5724>] bios32_service+0x1c/0x68
> [<c01f5780>] check_pcibios+0x10/0xd3
> [<c01f5a77>] pci_find_bios+0x70/0x8c

this is the known bug where by default Linux uses the BIOS services for
PCI rather than the native method.

try putting

pci=conf2

on the kerenl commandline

(and you may want to try a kernel newer than 2.6.8 btw)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com


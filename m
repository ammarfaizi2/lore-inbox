Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWINXTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWINXTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWINXTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:19:33 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:19656 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751358AbWINXTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:19:32 -0400
Subject: Re: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in
	get_memcfg_from_srat
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: dave hansen <haveblue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Vivek goyal <vgoyal@in.ibm.com>,
       ebiederm@xmission.com, andrew <akpm@osdl.org>
In-Reply-To: <1158274107.24414.8.camel@localhost.localdomain>
References: <1158113895.9562.13.camel@keithlap>
	 <1158269696.15745.5.camel@keithlap>
	 <1158271274.24414.6.camel@localhost.localdomain>
	 <1158273830.15745.14.camel@keithlap>
	 <1158274107.24414.8.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 14 Sep 2006 16:19:30 -0700
Message-Id: <1158275970.15745.20.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 15:48 -0700, Dave Hansen wrote:
> How do the ptes look?
rsdp->rsdt_address eff9c2c0
boot_ioremap phys_addr = eff9c2c0 long = 44
__boot_ioremap phys_addr = eff9c000 pages = 1 source c13db000
setting pte  c1682f6c to eff9c063
just flushed c13db000
boot_ioremap and I return c13db2c0
rsdt = c13db2c0 header is
ACPI: RSDT signature incorrect

the pte we get back from boot_vaddr_to_pte looks to be off be off (or
the data .  Seems odd we set the pte c1682f6c then flush c13db000....  

Still polking around.  I just read Viveks mail he seems to be onto
something. 

Thanks,
  Keith 


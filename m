Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTEMAnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTEMAnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:43:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17912 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263055AbTEMAnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:43:24 -0400
Message-ID: <3EC04261.6020206@us.ibm.com>
Date: Mon, 12 May 2003 17:54:57 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, James <jamesclv@us.ibm.com>
Subject: Re: [PATCH] linux-2.5.69_clear-smi-fix_A1
References: <1052785802.4169.12.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> All, 
> 	I've been having problems with ACPI on a box here in our lab. Some of
> our more recent hardware requires that SMIs are routed through the
> IOAPIC, thus when we clear_IO_APIC() at boot time, we clear the BIOS
> initialized SMI pin. This basically clobbers the SMI so we can then
> never make the transition into ACPI mode. 
> 
> This patch simply reads the apic entry in clear_IO_APIC to make sure the
> delivery_mode isn't dest_SMI. If it is, we leave the apic entry alone
> and return.
> 
> With this patch, the box boots and SMIs function properly.

So, without the patch, what happens?  Does the thing just completely
freeze when it tries to turn ACPI on?  Does the machine _require_ that
you use ACPI?

-- 
Dave Hansen
haveblue@us.ibm.com


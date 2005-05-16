Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVEPLOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVEPLOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVEPLOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:14:00 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:40538 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261478AbVEPLNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:13:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NblKyLn9dZsGFnf7ZzmhRroZxVcaLxzOPgCyqy/nPEdwWM3SNI1rk0vikCUmkFv1VgGmjM1Nw9uN8XSMDG3uWmoNQKRsbnM/a4bIILxtjmApW4aG4G/PnYANsSSFDPGw5dhZuRxrBgJsCPKweDIyiwmGMYNKL4dXk7EDzqxLdBk=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Danny ter Haar <dth@picard.cistron.nl>
Subject: Re: 2.6.12-rc4-mm2
Date: Mon, 16 May 2005 15:17:40 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20050516021302.13bd285a.akpm@osdl.org> <d69ttf$782$1@news.cistron.nl>
In-Reply-To: <d69ttf$782$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505161517.40802.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 May 2005 14:50, Danny ter Haar wrote:
> Andrew Morton  <akpm@osdl.org> wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm2/
> 
> include/acpi/achware.h:159: warning: `struct acpi_gpe_block_info' declared inside parameter list
> include/acpi/achware.h:159: warning: `struct acpi_gpe_xrupt_info' declared inside parameter list
> include/acpi/achware.h:159: warning: type defaults to `int' in declaration of `acpi_hw_enable_runtime_gpe_block'
> include/acpi/achware.h:159: warning: data definition has no type or storage class
> make[2]: *** [arch/x86_64/kernel/time.o] Error 1

Does this help?

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- linux-2.6.12-rc4-mm2/include/acpi/achware.h	2005-05-16 14:24:02.000000000 +0400
+++ linux-2.6.12-rc4-mm2-acpi/include/acpi/achware.h	2005-05-16 15:11:39.000000000 +0400
@@ -44,6 +44,14 @@
 #ifndef __ACHWARE_H__
 #define __ACHWARE_H__
 
+#include <linux/types.h>
+#include <acpi/actypes.h>
+
+struct acpi_bit_register_info;
+struct acpi_generic_address;
+struct acpi_gpe_event_info;
+struct acpi_gpe_xrupt_info;
+struct acpi_gpe_block_info;
 
 /* PM Timer ticks per second (HZ) */
 

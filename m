Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTEXUmV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 16:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbTEXUmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 16:42:21 -0400
Received: from fmr05.intel.com ([134.134.136.6]:8677 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S261159AbTEXUmT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 16:42:19 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Make ACPI compile again on 64bit/gcc 3.3
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Sat, 24 May 2003 13:55:26 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E96ED2@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Make ACPI compile again on 64bit/gcc 3.3
Thread-Index: AcMh0AMHuMr8YeypRK6v0N3aN4KOlgAZpP1A
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Andi Kleen" <ak@suse.de>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 May 2003 20:55:26.0884 (UTC) FILETIME=[CD8FD640:01C32236]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I think osl.c should be changed to match the header as it
stands. Could you try that and see if that also fixes things?

Thanks -- Regards -- Andy

> From: Andi Kleen [mailto:ak@suse.de] 
> Without this patch ACPI in BK-CVS current does not compile on 
> AMD64/gcc 3.3.
> 
> -Andi
> 
> 
> Index: linux/include/acpi/acpiosxf.h
> ===================================================================
> RCS file: /home/cvs/linux-2.5/include/acpi/acpiosxf.h,v
> retrieving revision 1.7
> diff -u -u -r1.7 acpiosxf.h
> --- linux/include/acpi/acpiosxf.h	24 May 2003 01:49:28 
> -0000	1.7
> +++ linux/include/acpi/acpiosxf.h	24 May 2003 07:32:37 -0000
> @@ -287,15 +287,15 @@
>   * Miscellaneous
>   */
>  
> -u8
> +BOOLEAN
>  acpi_os_readable (
>  	void                            *pointer,
> -	acpi_size                       length);
> +	u32                       	length);
>  
> -u8
> +BOOLEAN
>  acpi_os_writable (
>  	void                            *pointer,
> -	acpi_size                       length);
> +	u32                       	length);
>  
>  u32
>  acpi_os_get_timer (
> 

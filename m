Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267598AbTBFUHN>; Thu, 6 Feb 2003 15:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbTBFUHM>; Thu, 6 Feb 2003 15:07:12 -0500
Received: from fmr04.intel.com ([143.183.121.6]:7640 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267598AbTBFUHL>; Thu, 6 Feb 2003 15:07:11 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A164@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: gone@us.ibm.com, linux-kernel@vger.kernel.org
Cc: chandra.sekharan@us.ibm.com, cleverdj@us.ibm.com, johnstul@us.ibm.com
Subject: RE: [PATCH][RFC] Discontigmem support for the x440 
Date: Thu, 6 Feb 2003 12:16:34 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Patricia Gaughen [mailto:gone@us.ibm.com] 
> This patch provides discontigmem support for the IBM x440.  
> This code has 
> passed through the hands of several developers:  Chandra 
> Seetharaman, James 
> Cleverdon, John Stultz, and last to touch it, me :-)  This 
> patch requires full 
> acpi support.
> 
> I've tested this patch on an 8 way x440 16 GB of RAM with and 
> without HT 
> (acpi=off).
> 
> Any and all feedback regarding this patch is greatly appreciated.
> --- a/drivers/acpi/events/evevent.c	Wed Feb  5 19:15:58 2003
> +++ b/drivers/acpi/events/evevent.c	Wed Feb  5 19:15:58 2003
> @@ -104,6 +104,7 @@
>  
>  	ACPI_FUNCTION_TRACE ("ev_handler_initialize");
>  
> +	return_ACPI_STATUS (0);
>  
>  	/* Install the SCI handler */
>  

This part breaks ACPI event handling.

I'm guessing you just stuck that in there to get things working, but we
all need to figure out more of why this is an issue, and fix things
properly.

Other than that, thumbs up. SRAT support is a good thing to have.

Regards -- Andy

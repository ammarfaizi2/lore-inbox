Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUIMPRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUIMPRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268575AbUIMPIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:08:22 -0400
Received: from magic.adaptec.com ([216.52.22.17]:43679 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S267555AbUIMPAp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:00:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 2.4.28-pre3: broken ips update
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Mon, 13 Sep 2004 11:00:43 -0400
Message-ID: <A121ABA5B472B74EB59076B8E3C8F01979658B@rtpe2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.28-pre3: broken ips update
Thread-Index: AcSZoHcjo/kQwefdSL6PaUixWtvm5QAAXnqA
From: "Hammer, Jack" <Jack_Hammer@adaptec.com>
To: <arjanv@redhat.com>
Cc: "Adrian Bunk" <bunk@fs.tum.de>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I concur with Arjan's critique.  

Please disregard this patch and I will create a new one, with Arjan's
recommendation, shortly.

Jack 



-----Original Message-----
From: Arjan van de Ven [mailto:arjanv@redhat.com] 
Sent: Monday, September 13, 2004 10:46 AM
To: Hammer, Jack
Cc: Adrian Bunk; Marcelo Tosatti; linux-kernel@vger.kernel.org;
linux-scsi@vger.kernel.org
Subject: RE: 2.4.28-pre3: broken ips update

On Mon, 2004-09-13 at 16:28, Hammer, Jack wrote:
> Marcelo,

> --- linux.orig/drivers/scsi/ips.h	Mon Sep 13 09:40:04 2004
> +++ linux/drivers/scsi/ips.h	Mon Sep 13 09:40:27 2004
> @@ -97,7 +97,7 @@
>  
>     #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
>     
> -      #ifndef irqreturn_t
> +      #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23)
>           typedef void irqreturn_t;
>        #endif
> 

your fix is wrong.
you should nuke all version codes, and ONLY ifndef for  IRQ_NONE and
nothing else. That's not just cosmetics, that's also to make keep
working with those exact vendor kernels  you claim to have tested on :)



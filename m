Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUEMSZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUEMSZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUEMSZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:25:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:62364 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264371AbUEMSZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:25:13 -0400
Date: Thu, 13 May 2004 11:24:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: lkml@lpbproduction.scom
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.6-mm2
Message-Id: <20040513112447.5b8abca0.akpm@osdl.org>
In-Reply-To: <200405130514.44462.lkml@lpbproductions.com>
References: <20040513032736.40651f8e.akpm@osdl.org>
	<200405130514.44462.lkml@lpbproductions.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matt H." <lkml@lpbproductions.com> wrote:
>
> Just attempted to compile 2.6.6-mm2 and got this error
> 
>    CC [M]  drivers/usb/core/driverfs.o
>    CC [M]  drivers/usb/core/hcd-pci.o
>    LD [M]  drivers/usb/core/usbcore.o
>    LD      drivers/usb/host/built-in.o
>    CC [M]  drivers/usb/host/ehci-hcd.o
>    CC [M]  drivers/usb/host/ohci-hcd.o
>  In file included from drivers/usb/host/ohci-hcd.c:129:
>  drivers/usb/host/ohci-hub.c: In function `ohci_rh_resume':
>  drivers/usb/host/ohci-hub.c:313: error: `hcd' undeclared (first use in this 
>  function)

hm, not sure what's happened there...




---

 25-akpm/drivers/usb/host/ohci-hub.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/usb/host/ohci-hub.c~ohci-hub-build-fix drivers/usb/host/ohci-hub.c
--- 25/drivers/usb/host/ohci-hub.c~ohci-hub-build-fix	2004-05-13 11:23:48.588645576 -0700
+++ 25-akpm/drivers/usb/host/ohci-hub.c	2004-05-13 11:23:56.972371056 -0700
@@ -310,7 +310,7 @@ static void ohci_rh_resume (void *_hcd)
 
 static void ohci_rh_resume (void *_hcd)
 {
-	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
+	struct ohci_hcd	*ohci = hcd_to_ohci (_hcd);
 	ohci_dbg(ohci, "rh_resume ??\n");
 }
 

_


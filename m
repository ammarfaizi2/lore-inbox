Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268097AbTCFN7R>; Thu, 6 Mar 2003 08:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268090AbTCFN7R>; Thu, 6 Mar 2003 08:59:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65037 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268097AbTCFN7P>; Thu, 6 Mar 2003 08:59:15 -0500
Date: Thu, 6 Mar 2003 14:09:45 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: CaT <cat@zip.com.au>
Cc: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 - xircom realport no workie well
Message-ID: <20030306140945.B838@flint.arm.linux.org.uk>
Mail-Followup-To: CaT <cat@zip.com.au>, dahinds@users.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030306130340.GA453@zip.com.au> <20030306132904.A838@flint.arm.linux.org.uk> <20030306134746.GE464@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030306134746.GE464@zip.com.au>; from cat@zip.com.au on Fri, Mar 07, 2003 at 12:47:46AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 12:47:46AM +1100, CaT wrote:
> On Thu, Mar 06, 2003 at 01:29:04PM +0000, Russell King wrote:
> > Can you check whether the attached patch fixes this for you?  It's more
> 
> Started compiling it and it just bombed out:
> 
> drivers/serial/8250_pci.c:1920: `PCI_DEVICE_ID_XIRCOM_RBM56G' undeclared
> here (not in a function)
> drivers/serial/8250_pci.c:1920: initializer element is not constant
> drivers/serial/8250_pci.c:1920: (near initialization for
> `serial_pci_tbl[86].device')

Bah.  You need this as well then:

--- orig/include/linux/pci_ids.h	Wed Mar  5 19:51:58 2003
+++ linux/include/linux/pci_ids.h	Wed Mar  5 09:58:27 2003
@@ -1235,6 +1235,7 @@
 
 #define PCI_VENDOR_ID_XIRCOM		0x115d
 #define PCI_DEVICE_ID_XIRCOM_X3201_ETH	0x0003
+#define PCI_DEVICE_ID_XIRCOM_RBM56G	0x0101
 #define PCI_DEVICE_ID_XIRCOM_X3201_MDM	0x0103
 
 #define PCI_VENDOR_ID_RENDITION		0x1163


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


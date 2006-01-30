Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWA3Ndd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWA3Ndd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWA3Ndd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:33:33 -0500
Received: from mx02.qsc.de ([213.148.130.14]:65156 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S932255AbWA3Ndc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:33:32 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Adaptec USBXchange and USB2Xchange support
Date: Mon, 30 Jan 2006 14:33:14 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Louis C. Kouvaris" <louisk@comcast.net>,
       "wilford smith" <wilford_smith_2@hotmail.com>
References: <200509132253.53960.rene@exactcode.de> <20050914031827.69ad98e5.akpm@osdl.org> <200601301422.40500.rene@exactcode.de>
In-Reply-To: <200601301422.40500.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601301433.15009.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Monday 30 January 2006 14:22,  =?ISO-8859-1?Q?=20Ren=E9?= Rebe wrote:
	ouhm, one forgotten dependency slipped in due final code reorganization:
	[...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 30 January 2006 14:22, René Rebe wrote:

ouhm, one forgotten dependency slipped in due final code reorganization:

> +config USB_USBXCHANGE
> +	tristate "Adaptec USBXchange and USB2Xchange firmware loader"
> +	depends on USB_STORAGE_USBXCHANGE

--- old	2006-01-30 14:30:04.859858250 +0100
+++ adaptec-usbxchange.patch	2006-01-30 14:30:12.408330000 +0100
@@ -7,7 +7,7 @@
  
 +config USB_USBXCHANGE
 +	tristate "Adaptec USBXchange and USB2Xchange firmware loader"
-+	depends on USB_STORAGE_USBXCHANGE
++	depends on USB_STORAGE
 +	help
 +	  Say Y here to include additional code to load the firmware into the
 +	  Adaptec USBXchange and USB2Xchange USB --> SCSI converter dongle.

Or just drop the depends entirely, since it only logically depends on USB_STORAGE -
not technically.

Sorry - yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45

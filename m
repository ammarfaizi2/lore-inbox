Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265534AbUFDALX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265534AbUFDALX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 20:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265484AbUFDAIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 20:08:42 -0400
Received: from holomorphy.com ([207.189.100.168]:3234 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265361AbUFDAHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 20:07:52 -0400
Date: Thu, 3 Jun 2004 17:07:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: vojtech@suse.cz
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040604000718.GP21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	vojtech@suse.cz, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040602132654.GY2093@holomorphy.com> <20040603233828.GA27504@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603233828.GA27504@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 06:26:54AM -0700, William Lee Irwin III wrote:
>> Fix warnings about various structs declared inside parameter lists and so
>> on seen while compiling compat_ioctl.c.

On Thu, Jun 03, 2004 at 04:38:28PM -0700, Greg KH wrote:
> Doesn't apply to my, or a clean -rc2 tree :(
> Probably needs to be sent to Vojtech and put in his tree.
> thanks,
> greg k-h

Vojtech, gregkh referred me to you for this change. Some compilation
failures are caused by some changes to hiddev.h or some surrounding
area in -mm; this patch resolves them.

Thanks.

-- wli

Index: linux-2.6.7-rc2/include/linux/hiddev.h
===================================================================
--- linux-2.6.7-rc2.orig/include/linux/hiddev.h	2004-06-01 03:11:37.000000000 -0700
+++ linux-2.6.7-rc2/include/linux/hiddev.h	2004-06-02 06:15:34.807765000 -0700
@@ -213,12 +213,12 @@
  * In-kernel definitions.
  */
 
-#ifdef CONFIG_USB_HIDDEV
 struct hid_device;
 struct hid_usage;
 struct hid_field;
 struct hid_report;
 
+#ifdef CONFIG_USB_HIDDEV
 int hiddev_connect(struct hid_device *);
 void hiddev_disconnect(struct hid_device *);
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,

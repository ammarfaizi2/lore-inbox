Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUFBN3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUFBN3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUFBN3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:29:34 -0400
Received: from holomorphy.com ([207.189.100.168]:31127 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262874AbUFBN1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:27:17 -0400
Date: Wed, 2 Jun 2004 06:26:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040602132654.GY2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	greg@kroah.com
References: <20040601021539.413a7ad7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601021539.413a7ad7.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 02:15:39AM -0700, Andrew Morton wrote:
> - NFS server udpates
> - md updates
> - big x86 dmi_scan.c cleanup
> - merged perfctr.  No documentation though :(
> - cris architecture update

Fix warnings about various structs declared inside parameter lists and so
on seen while compiling compat_ioctl.c.


Index: mm1-2.6.7-rc2/include/linux/hiddev.h
===================================================================
--- mm1-2.6.7-rc2.orig/include/linux/hiddev.h	2004-06-01 03:11:37.000000000 -0700
+++ mm1-2.6.7-rc2/include/linux/hiddev.h	2004-06-02 06:15:34.807765000 -0700
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

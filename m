Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUJWEjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUJWEjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269233AbUJWEdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:33:15 -0400
Received: from [211.58.254.17] ([211.58.254.17]:913 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S268447AbUJWE2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:28:03 -0400
Date: Sat, 23 Oct 2004 13:28:00 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (7/16)
Message-ID: <20041023042800.GH3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_07_param_array_delim_colon.diff

 This is the 7th patch of 16 patches for devparam.

 This adds ':' to the delimeters for param_array().  ':' is used as
the nested array delimeter in devparam.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/include/linux/moduleparam.h
===================================================================
--- linux-devparam-export.orig/include/linux/moduleparam.h	2004-10-23 11:09:29.000000000 +0900
+++ linux-devparam-export/include/linux/moduleparam.h	2004-10-23 11:09:29.000000000 +0900
@@ -193,7 +193,7 @@ static inline int param_array(const char
 {
 	return param_array_delims(name, val, min_val, max_val,
 				  min_elems, max_elems, elem, elemsize,
-				  set, num, ",");
+				  set, num, ",:");
 }
 
 #endif /* _LINUX_MODULE_PARAMS_H */

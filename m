Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWFWAtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWFWAtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWFWAtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:49:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22508 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751031AbWFWAtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:49:39 -0400
Date: Thu, 22 Jun 2006 20:49:30 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Subject: fix oddball boolean logic in s390 netiucv
Message-ID: <20060623004930.GA16599@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/s390/net/netiucv.c~	2006-06-22 20:47:35.000000000 -0400
+++ linux-2.6/drivers/s390/net/netiucv.c	2006-06-22 20:48:05.000000000 -0400
@@ -2029,7 +2029,7 @@ remove_write (struct device_driver *drv,
                 count = IFNAMSIZ-1;
 
         for (i=0, p=(char *)buf; i<count && *p; i++, p++) {
-                if ((*p == '\n') | (*p == ' ')) {
+                if ((*p == '\n') || (*p == ' ')) {
                         /* trailing lf, grr */
                         break;
                 } else {

-- 
http://www.codemonkey.org.uk

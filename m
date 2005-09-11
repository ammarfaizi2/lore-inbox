Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVIKA7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVIKA7l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVIKA7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:59:41 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:24349 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964787AbVIKA7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:59:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=SEmVD85EzkOaPliqQ/PzWepRh+vvVRP8GQoAgU7YfCgdpc9MDVPie+TOyzdXd5me4PIakXryrt/hUXhqgRpz0BI0/eeMupqIJ/C0AHtcOtOhJQxv9lG9uDyi3UOW6yBYHqSH8tOjBKriuCRzG0+m47YT4kG1c0VrGthRaHFqFOs=
Date: Sun, 11 Sep 2005 05:09:36 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Documentation/ioctl-mess.txt format
Message-ID: <20050911010935.GA10781@mipter.zuzino.mipt.ru>
References: <20050911005342.GC32299@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911005342.GC32299@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that first two patches hit -mm (thanks, Andrew), please, comment
on:

a) Layout.

   This one is a-la MAINTAINERS, CREDITS. I like it.

b) Fields for future additions.

   Input and output wrt userspace are the easiest ones to extract, so
   I'll do them first.

   Obviously, "D: " should exist (already found some good descriptions
   under GFDL, arrgh). Possibly "R: " -- return values. Following code
   can be tricky and deep.

P. S.: some of you would like to see "P: " field very much, but that
       would require a _lot_ of archaeology. ;-)

--- linux-ioctl-mess.txt-000/Documentation/ioctl-mess.txt
+++ linux-ioctl-mess.txt-001/Documentation/ioctl-mess.txt
@@ -7,23 +7,66 @@ time for patch-cooking, simple "there is
 would also be fine.
 
 Please, keep the list in alphabetical order.
+
+Legend
+------
+N: NAME
+I: data copied from userspace with copy_from_user(), or
+	"I: (int) arg", or
+	"I: -".
+O: data copied to userspace with copy_to_user() or put_user(), or
+	"O: -".
 ----------------------------------------------------------------------------
 0x1260
 0x41545900
 0x41545901
 0x4B50
 0x4B51
-ADD_NEW_DISK
-AGPIOC_ACQUIRE
-AGPIOC_ALLOCATE
-AGPIOC_BIND
-AGPIOC_DEALLOCATE
-AGPIOC_INFO
-AGPIOC_PROTECT
-AGPIOC_RELEASE
-AGPIOC_RESERVE
-AGPIOC_SETUP
-AGPIOC_UNBIND
+
+N: ADD_NEW_DISK
+I: mdu_disk_info_t
+O: -
+
+N: AGPIOC_ACQUIRE
+I: -
+O: -
+
+N: AGPIOC_ALLOCATE
+I: struct agp_allocate
+O: struct agp_allocate
+
+N: AGPIOC_BIND
+I: struct agp_bind
+O: -
+
+N: AGPIOC_DEALLOCATE
+I: int (arg)
+O: -
+
+N: AGPIOC_INFO
+I: -
+O: struct agp_info
+
+N: AGPIOC_PROTECT
+I: -
+O: -
+
+N: AGPIOC_RELEASE
+I: -
+O: -
+
+N: AGPIOC_RESERVE
+I: struct agp_region [+ sizeof(struct agp_segment) * struct agp_region::seg_count)]
+O: -
+
+N: AGPIOC_SETUP
+I: struct agp_setup
+O: -
+
+N: AGPIOC_UNBIND
+I: struct agp_unbind
+O: -
+
 AMDTP_IOC_ZAP
 APM_IOC_STANDBY
 APM_IOC_SUSPEND


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVGGLgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVGGLgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVGGLdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:33:50 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:56499 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261299AbVGGLcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:32:25 -0400
Message-ID: <42CD12C4.8010200@ens-lyon.org>
Date: Thu, 07 Jul 2005 13:32:20 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm1
References: <20050707040037.04366e4e.akpm@osdl.org>
In-Reply-To: <20050707040037.04366e4e.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020907090203040505090206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020907090203040505090206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Le 07.07.2005 13:00, Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc2/2.6.13-rc2-mm1/
> 
> (kernel.org seems to be stuck again - there's a copy at
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc2-mm1.gz)

  CC      kernel/power/disk.o
kernel/power/disk.c: Dans la fonction « software_resume »:
kernel/power/disk.c:242: attention : implicit declaration of function
`name_to_dev_t'

The attached patch adds an extern declaration in disk.c as it's
already done in swsusp.c

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Regards,
Brice

--------------020907090203040505090206
Content-Type: text/x-patch;
 name="add_extern_name_to_dev_t_to_power_disk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_extern_name_to_dev_t_to_power_disk.patch"

--- linux-mm/kernel/power/disk.c.old	2005-07-07 13:28:52.000000000 +0200
+++ linux-mm/kernel/power/disk.c	2005-07-07 13:30:02.000000000 +0200
@@ -30,6 +30,7 @@ extern void swsusp_close(void);
 extern int swsusp_resume(void);
 extern int swsusp_free(void);
 
+extern dev_t name_to_dev_t(const char *line);
 
 static int noresume = 0;
 char resume_file[256] = CONFIG_PM_STD_PARTITION;

--------------020907090203040505090206--

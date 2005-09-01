Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030525AbVIAXZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbVIAXZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbVIAXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:25:42 -0400
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:20887
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S1030525AbVIAXZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:25:41 -0400
Message-ID: <43178DC5.1030405@winischhofer.net>
Date: Fri, 02 Sep 2005 01:24:53 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: 2.6.13-mm1: broken drivers/video/sis/Makefile
References: <20050901035542.1c621af6.akpm@osdl.org> <20050901221959.GB3657@stusta.de>
In-Reply-To: <20050901221959.GB3657@stusta.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------000408030309030601020408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000408030309030601020408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian Bunk wrote:
> On Thu, Sep 01, 2005 at 03:55:42AM -0700, Andrew Morton wrote:
> 
>>...
>>Changes since 2.6.13-rc6-mm2:
>>...
>>+sisfb-update.patch
>>...
>> fbdev updates
>>...
> 
> 
> This patch accidentally replaces drivers/video/sis/Makefile with a 
> toplevel Makefile.

ARGH..... that happens if you work with four trees at the same time...

My appologies. Correct Makefile-patch attached.

Thomas

- --
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDF43FzydIRAktyUcRAptjAKDPQeYc3v5Ulu+HKnbRINsCNcfwwgCgkWnD
sJnT86TfSyX45JIW2KKRLog=
=TDOr
-----END PGP SIGNATURE-----

--------------000408030309030601020408
Content-Type: text/plain;
 name="sisfb_mf_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sisfb_mf_patch.diff"

--- linux-2.6.13-orig/drivers/video/sis/Makefile	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-sisfb/drivers/video/sis/Makefile	2005-09-02 01:22:29.247255624 +0200
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FB_SIS) += sisfb.o
 
-sisfb-objs := sis_main.o sis_accel.o init.o init301.o
+sisfb-objs := sis_main.o sis_accel.o init.o init301.o initextlfb.o

--------------000408030309030601020408--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWI1SuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWI1SuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWI1SuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:50:21 -0400
Received: from xenotime.net ([66.160.160.81]:52928 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161007AbWI1SuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:50:19 -0400
Date: Thu, 28 Sep 2006 11:51:34 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Judith Lebzelter <judith@osdl.org>
Cc: linux-kernel@vger.kernel.org, vda@ilport.com.ua, akpm@osdl.org,
       acx100-devel@lists.sourceforge.net
Subject: Re: 2.6.18-mm1 tiacx-fix-attribute-packed-warnings for wlan
Message-Id: <20060928115134.92738bb4.rdunlap@xenotime.net>
In-Reply-To: <20060928173421.GG26041@shell0.pdx.osdl.net>
References: <20060928173421.GG26041@shell0.pdx.osdl.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 10:34:21 -0700 Judith Lebzelter wrote:

> Hello,
> 
> The patch tiacx-fix-attribute-packed-warnings.patch takes care of many of 
> the 'packed attribute' warnings, but I noticed that some of these warnings like:
> 
> drivers/net/wireless/tiacx/wlan_compat.h:246: warning: 'packed' attribute ignored for field of type 'u8[5u]'
> drivers/net/wireless/tiacx/wlan_hdr.h:476: warning: 'packed' attribute ignored for field of type 'wlanitem_u32_t'
> drivers/net/wireless/tiacx/wlan_mgmt.h:253: warning: 'packed' attribute ignored for field of type 'u8'
> 
> are still present for the i386/allmodconfig build on gcc-4.1.1 for 2.6.18-mm1.  
> So I made a patch for the files where it is still a problem.  This compiled
> without warnings.


Hello,

How are you creating/generating patch files?  (git, quilt, by hand, ...)
[quilt can help a bit if your answer is "by hand" or by custom tools.]

Please see Documentation/SubmittingPatches, e.g.:

section 12) The canonical patch format

Consider including output of "diffstat -p1 -w70" after the
"---" marker so that patch readers can see what files are
changed and how much.

Please add diff option "-p" also.

(all mentioned in SubmittingPatches)

> diff -Nur linux.nodelta/drivers/net/wireless/tiacx/wlan_compat.h linux/drivers/net/wireless/tiacx/wlan_compat.h
> --- linux.nodelta/drivers/net/wireless/tiacx/wlan_compat.h	2006-09-28 09:06:00.628523695 -0700
> +++ linux/drivers/net/wireless/tiacx/wlan_compat.h	2006-09-28 09:50:59.301786662 -0700
> @@ -243,20 +243,20 @@

Thanks.
---
~Randy

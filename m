Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUJBBXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUJBBXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 21:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUJBBXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 21:23:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:48290 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267164AbUJBBXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 21:23:19 -0400
Subject: Re: [Alsa-devel] alsa-driver will not compile with kernel
	2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <1096679629.22244.4.camel@krustophenia.net>
References: <1096675930.27818.74.camel@krustophenia.net>
	 <32868.192.168.1.8.1096677269.squirrel@192.168.1.8>
	 <20041002004854.GB26711@thundrix.ch>
	 <1096678383.27818.87.camel@krustophenia.net>
	 <1096679629.22244.4.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1096680198.22244.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 21:23:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 21:13, Lee Revell wrote:
> For now unset CONFIG_OLD_REMAP_PAGE_RANGE and it should work.  Not yet
> tested.

Yup, this works.  Trivial patch:

--- alsa-driver/configure~	2004-09-29 16:05:19.000000000 -0400
+++ alsa-driver/configure	2004-10-01 21:14:20.000000000 -0400
@@ -6629,7 +6629,7 @@
 CFLAGS=$ac_save_CFLAGS
 if test "$new_remap" != "1"; then
   cat >>confdefs.h <<\_ACEOF
-#define CONFIG_OLD_REMAP_PAGE_RANGE 1
+#undef CONFIG_OLD_REMAP_PAGE_RANGE
 _ACEOF
 
 fi

Lee


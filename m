Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWDEKWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWDEKWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 06:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWDEKWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 06:22:34 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:30282 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751200AbWDEKWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 06:22:33 -0400
X-ME-UUID: 20060405102231917.E001F1C00215@mwinf0512.wanadoo.fr
Subject: Re: [PATCH] Doc; fix mtrr userspace programs to build cleanly
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, rgooch@atnf.csiro.au,
       akpm <akpm@osdl.org>
In-Reply-To: <20060404201511.6859070a.rdunlap@xenotime.net>
References: <20060404201511.6859070a.rdunlap@xenotime.net>
Content-Type: text/plain
Message-Id: <1144232544.2874.101.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Wed, 05 Apr 2006 12:22:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2006-04-05 at 05:15, Randy.Dunlap wrote:
> +static char *mtrr_strings[MTRR_NUM_TYPES] =
> +{
> +    "uncachable",               /* 0 */
> +    "write-combining",          /* 1 */
> +    "?",                        /* 2 */
> +    "?",                        /* 3 */
> +    "write-through",            /* 4 */
> +    "write-protect",            /* 5 */
> +    "write-back",               /* 6 */
> +};

How about something like that ?

+static char *mtrr_strings[MTRR_NUM_TYPES] =
+{
+    [MTRR_TYPE_UNCACHABLE] = "uncachable",               /* 0 */
+    [MTRR_TYPE_WRCOMB]     = "write-combining",          /* 1 */
+                             "?",                        /* 2 */
+                             "?",                        /* 3 */
+    [MTRR_TYPE_WRTHROUGH]  = "write-through",            /* 4 */
+    [MTRR_TYPE_WRPROT]     = "write-protect",            /* 5 */
+    [MTRR_TYPE_WRBACK]     = "write-back",               /* 6 */
+};

(Dunno if it's that helpful though).

	Xav



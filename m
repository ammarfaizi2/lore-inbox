Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVKMOvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVKMOvk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 09:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVKMOvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 09:51:40 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:20972 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932511AbVKMOvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 09:51:39 -0500
Message-ID: <437752FF.9060200@m1k.net>
Date: Sun, 13 Nov 2005 09:51:43 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix missing includes for 2.6.15-rc1
References: <Pine.LNX.4.63.0511131323250.9037@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.63.0511131323250.9037@gockel.physik3.uni-rostock.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:

>Include fixes for 2.6.15-rc1 for removing sched.h from module.h.
>Compile tested on alpha, arm, ia64, mips, powerpc, ppc64, and x86_64.
>
>Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>
>---
>Andrew:
>This one is incremental on top of fix-missing-includes-for-2.6.14-git11.patch
>
>  
>
[snip]

>diff -urp linux-2.6.15-rc1-sr0/drivers/media/dvb/frontends/nxt200x.c linux-2.6.15-rc1-sr2/drivers/media/dvb/frontends/nxt200x.c
>--- linux-2.6.15-rc1-sr0/drivers/media/dvb/frontends/nxt200x.c	2005-11-13 10:19:44.000000000 +0100
>+++ linux-2.6.15-rc1-sr2/drivers/media/dvb/frontends/nxt200x.c	2005-11-13 10:21:36.000000000 +0100
>@@ -44,6 +44,8 @@
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/moduleparam.h>
>+#include <linux/slab.h>
>+#include <linux/string.h>
> 
> #include "dvb_frontend.h"
> #include "dvb-pll.h"
>  
>
This portion of the patch has been applied to dvb-kernel cvs.

Acked-by: Michael Krufky <mkrufky@m1k.net>

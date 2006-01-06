Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWAFVU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWAFVU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWAFVU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:20:27 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24249
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932280AbWAFVU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:20:27 -0500
Date: Fri, 06 Jan 2006 13:17:34 -0800 (PST)
Message-Id: <20060106.131734.78923714.davem@davemloft.net>
To: jengelh@linux01.gwdg.de
Cc: lcapitulino@mandriva.com.br, akpm@osdl.org, robert.olsson@its.uu.se,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pktgen: Adds missing __init.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0601062003000.28630@yvahk01.tjqt.qr>
References: <20060106131108.53411909.lcapitulino@mandriva.com.br>
	<Pine.LNX.4.61.0601062003000.28630@yvahk01.tjqt.qr>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Fri, 6 Jan 2006 20:04:13 +0100 (MET)

> >diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> >index 06cad2d..5eeae0d 100644
> >--- a/net/core/pktgen.c
> >+++ b/net/core/pktgen.c
> >@@ -2883,7 +2883,7 @@ static int pktgen_add_device(struct pktg
> > 	return add_dev_to_thread(t, pkt_dev);
> > }
> > 
> >-static struct pktgen_thread *pktgen_find_thread(const char* name) 
> >+static struct pktgen_thread __init *pktgen_find_thread(const char* name) 
> 
> I do not know what CodingStyle says about it (it is correct GCC code),
> what do the others think of the more often placement of __init as in
>   __init static struct pktgen_thread *pktgen_find_thread(const char *name)
> or
>   static __init struct pktgen_thread *pktgen_find_thread(const char *name)
> [depending on what people like]

It should be right before the function name, "struct foo *" is a full
return type specification, so any other attributes should appear either
before or after that.

I'll fix this up when I apply Luis's patch.

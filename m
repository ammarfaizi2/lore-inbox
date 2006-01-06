Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWAFTFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWAFTFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWAFTFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:05:06 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:19107 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932467AbWAFTEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:04:43 -0500
Date: Fri, 6 Jan 2006 20:04:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
cc: akpm <akpm@osdl.org>, robert.olsson@its.uu.se, netdev@oss.sgi.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pktgen: Adds missing __init.
In-Reply-To: <20060106131108.53411909.lcapitulino@mandriva.com.br>
Message-ID: <Pine.LNX.4.61.0601062003000.28630@yvahk01.tjqt.qr>
References: <20060106131108.53411909.lcapitulino@mandriva.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>diff --git a/net/core/pktgen.c b/net/core/pktgen.c
>index 06cad2d..5eeae0d 100644
>--- a/net/core/pktgen.c
>+++ b/net/core/pktgen.c
>@@ -2883,7 +2883,7 @@ static int pktgen_add_device(struct pktg
> 	return add_dev_to_thread(t, pkt_dev);
> }
> 
>-static struct pktgen_thread *pktgen_find_thread(const char* name) 
>+static struct pktgen_thread __init *pktgen_find_thread(const char* name) 

I do not know what CodingStyle says about it (it is correct GCC code),
what do the others think of the more often placement of __init as in
  __init static struct pktgen_thread *pktgen_find_thread(const char *name)
or
  static __init struct pktgen_thread *pktgen_find_thread(const char *name)
[depending on what people like]



Jan Engelhardt
-- 

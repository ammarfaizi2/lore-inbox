Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTFJJv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTFJJv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:51:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:25085 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261352AbTFJJvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:51:24 -0400
Date: Tue, 10 Jun 2003 15:37:46 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: x25-facilities-parse
Message-ID: <20030610100746.GC2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100527.GA2194@in.ibm.com> <20030610100643.GB2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610100643.GB2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix parsing of options for X.25 facilities


 net/x25/x25_facilities.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN net/x25/x25_facilities.c~x25-facilities-parse net/x25/x25_facilities.c
--- linux-2.5.70-ds/net/x25/x25_facilities.c~x25-facilities-parse	2003-06-08 00:39:39.000000000 +0530
+++ linux-2.5.70-ds-dipankar/net/x25/x25_facilities.c	2003-06-08 00:40:28.000000000 +0530
@@ -105,8 +105,8 @@ int x25_parse_facilities(struct sk_buff 
 			printk(KERN_DEBUG "X.25: unknown facility %02X, "
 			       "length %d, values %02X, %02X, %02X, %02X\n",
 			       p[0], p[1], p[2], p[3], p[4], p[5]);
-			p   += p[1] + 2;
 			len -= p[1] + 2;
+			p   += p[1] + 2;
 			break;
 		}
 	}

_

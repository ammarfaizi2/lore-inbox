Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUHaU3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUHaU3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269167AbUHaU3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:29:01 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:16517 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S266871AbUHaU1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:27:40 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Wed, 1 Sep 2004 04:28:00 +0800
User-Agent: KMail/1.5.4
Cc: adaplas@pol.net
References: <200408312133.40039.ornati@fastwebnet.it>
In-Reply-To: <200408312133.40039.ornati@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409010428.01056.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 03:33, Paolo Ornati wrote:

> Tests with "linux/MAINTAINERS" (time cat MAINTAINERS)
> 2.6.8.1
> 	real    0m2.625s
> 	user    0m0.000s
> 	sys     0m2.621s
>
> 2.6.9-rc1
> 	real    0m13.528s
> 	user    0m0.000s
> 	sys     0m13.553s
>

Open drivers/video/tdfxfb.c, change the following (at line 1278):

info->flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;

to

info->flags		= FBINFO_DEFAULT;

Let me know of the results.

Tony



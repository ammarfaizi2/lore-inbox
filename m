Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbUJXSpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbUJXSpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUJXSpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:45:31 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51195 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261583AbUJXSpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:45:15 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: Joerg Sommrey <jo175@sommrey.de>
Subject: Re: Bug? Load avg 2.0 when idle.
Date: Sun, 24 Oct 2004 20:45:04 +0200
User-Agent: KMail/1.7
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041024182918.GA12532@sommrey.de>
In-Reply-To: <20041024182918.GA12532@sommrey.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410242045.04901.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Sommrey wrote:
> there is a load average of 2.0+ even if the box is almost idle. (i.e.
> "top" shows just one running process: top itself.) Starting two
> cpu-intensive processes raises the load average to 4.0+.  How can I
> determine the source for the high load, or is this a bug?
> I'm running 2.6.9 on a dual-athlon box.

Besides other possibilities, a bug in the kernel could be the cause. 
Please check if any process (one or two) is in uninterruptible sleep. 
(using ps axl the state is D)
Furthermore, Magic SysRequest+T (alt-print-t) and the dmesg output could 
give some hints.
If there is nothing suspicious you might try some profiling tool, e.g. 
OProfile. 

There was another bug report about a wrap around load average. I dont know 
if both reports are related. 

cheers

Christian


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbUBUEJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 23:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUBUEJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 23:09:54 -0500
Received: from [65.248.111.151] ([65.248.111.151]:23172 "EHLO
	ns1.brianandsara.net") by vger.kernel.org with ESMTP
	id S261512AbUBUEJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 23:09:49 -0500
From: Brian Jackson <brian@brianandsara.net>
Organization: brianandsara.net
To: hanasaki <hanasaki@hanaden.com>
Subject: Re: 2.6.3 AGP fallback to slower speeds
Date: Fri, 20 Feb 2004 22:10:46 -0600
User-Agent: KMail/1.6.50
Cc: LIST - Linux Kernel <linux-kernel@vger.kernel.org>
References: <4036C5A2.6080703@hanaden.com>
In-Reply-To: <4036C5A2.6080703@hanaden.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402202210.46099.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 February 2004 20:42, hanasaki wrote:
> Hello all,
>
> Running 2.6.3 on debian sarge and having the following problem reported
> in syslog at boot up.  Any thoughts on what is going on here and how to
> fix it?
>
> motherboard	- soyo dragon ultra platinum kt600
> video card	- ati 9000 pro 256meg

the 9000's are only 8x compatible, not really an 8x card (meaning they will 
work in a 8x board, just not at 8x)

> xfree		- 4.3 - says drm loads
> 			glxinfo says "direct rendering: No"
>
>
> === snip from lsmod ===
> via_agp                 6272  1
> agpgart                27308  2 via_agp
> radeon                115948  2
> ===========
>
> === snip from lspci ===
> 00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
> 01:00.0 VGA compatible controller: ATI Technologies Inc
> 	Radeon R250 If [Radeon 9000] (rev 01)
> 01:00.1 Display controller: ATI Technologies Inc
> 	Radeon R250 [Radeon 9000] (Secondary) (rev 01)
> =============
>
> == from syslog ==
> Feb 20 19:20:50  kernel: agpgart: Found an AGP 3.5
> 	compliant device at 0000:00:00.0.
> Feb 20 19:20:50  kernel: agpgart: Device is in legacy mode,
> 	falling back to 2.x
> Feb 20 19:20:50  kernel: agpgart: Putting AGP V2 device
> 	at 0000:00:00.0 into 1x mode
> Feb 20 19:20:50  kernel: agpgart: Putting AGP V2 device
> 	at 0000:01:00.0 into 1x mode
> Feb 20 19:20:50  kernel: agpgart: Putting AGP V2 device
> 	at 0000:01:00.1 into 1x mode
> ==========
-- 
http://www.brianandsara.net

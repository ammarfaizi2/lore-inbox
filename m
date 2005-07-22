Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVGVVrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVGVVrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVGVVp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:45:29 -0400
Received: from [64.34.38.30] ([64.34.38.30]:950 "EHLO mercury.illhostit.com")
	by vger.kernel.org with ESMTP id S262198AbVGVVnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:43:45 -0400
From: "John Pearson" <john@illhostit.com>
To: "Erik Mouw" <erik@harddisk-recovery.com>, "Ashley" <ashleyz@alchip.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel cached memory
Date: Fri, 22 Jul 2005 14:43:43 -0700
Message-ID: <JCEEICIEKCENOEGFMGBACEAGCAAA.john@illhostit.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20050722125746.GG20258@harddisk-recovery.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mercury.illhostit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - illhostit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wouldn't having (practically) all your memory used for cache slow down
starting a new program? First it would have to free up that space, and then
put stuff in that space, taking potentially twice as long. I think there
should be a system call for freeing cached memory, for those that do want to
do it.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Erik Mouw
Sent: Friday, July 22, 2005 5:58 AM
To: Ashley
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel cached memory


On Fri, Jul 22, 2005 at 05:46:58PM +0800, Ashley wrote:
>    I've a server with 2 Operton 64bit CPU and 12G memory, and this server
> is used to run  applications which will comsume huge memory,
> the problem is: when this aplications exits,  the free memory of the
server
> is still very low(accroding to the output of "top"), and
> from the output of command "free", I can see that many GB memory was
cached
> by kernel. Does anyone know how to free the kernel cached
> memory? thanks in advance.

Free memory is bad, it means the memory doesn't have a proper use.
Cached memory will be freed automatically when the kernel needs memory
for other (more important) things.


Erik

--
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


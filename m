Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136424AbRD3BIR>; Sun, 29 Apr 2001 21:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136422AbRD3BIH>; Sun, 29 Apr 2001 21:08:07 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:34285 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S136424AbRD3BHv>;
	Sun, 29 Apr 2001 21:07:51 -0400
Date: Mon, 30 Apr 2001 02:06:17 +0100 (BST)
From: Dave Jones <davej@suse.de>
X-X-Sender: <davej@athlon>
To: Steffen Persvold <sp@scali.no>
cc: lkml <linux-kernel@vger.kernel.org>, <troels@thule.no>
Subject: Re: ServerWorks LE and MTRR
In-Reply-To: <3AEC6384.C59FAC9@scali.no>
Message-ID: <Pine.LNX.4.31.0104300202260.30825-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Apr 2001, Steffen Persvold wrote:

> ...
> Therefore please consider my small patch to allow the
> good ones to be able to use write-combining. I have several rev 06 and they are
> working fine with this patch.
> ...

ObPedant:
 Can you make a note of this in the comment a few lines above also,
so others who stumble across this code know why the check is there.
afaik, this chipset info isn't public, so it may not be obvious
in the future why the check has been added.

Just something simple like..

-    /* ServerWorks LE chipsets have problems with  write-combining
+    /* ServerWorks LE chipsets < rev 6 have problems with write-combining
       Don't allow it and  leave room for other chipsets to be tagged */


Otherwise, if this works for everyone else with rev 6+ serverworks
chipsets, looks ok to me.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs


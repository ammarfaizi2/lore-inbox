Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133019AbRD3NqF>; Mon, 30 Apr 2001 09:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135216AbRD3Npz>; Mon, 30 Apr 2001 09:45:55 -0400
Received: from ausxc08.us.dell.com ([143.166.99.216]:43337 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S133019AbRD3Npm>; Mon, 30 Apr 2001 09:45:42 -0400
Message-ID: <CDF99E351003D311A8B0009027457F1402F7EB8F@ausxmrr501.us.dell.com>
From: Mark_Rusk@Dell.com
To: linux-kernel@vger.kernel.org
Subject: RE: ServerWorks LE and MTRR
Date: Mon, 30 Apr 2001 08:44:00 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had sent the original patch to Alan back in the Feb. to correct problems
with XFree 4.0.2 and LE chipsets.  I will check that the problem is
corrected with Rev's >5. We would see complete system lockups when the Xfree
server would use write-combining mtrr segments. 

-----Original Message-----
From: Dave Jones [mailto:davej@suse.de]
Sent: Sunday, April 29, 2001 8:06 PM
To: Steffen Persvold
Cc: lkml; troels@thule.no
Subject: Re: ServerWorks LE and MTRR


On Sun, 29 Apr 2001, Steffen Persvold wrote:

> ...
> Therefore please consider my small patch to allow the
> good ones to be able to use write-combining. I have several rev 06 and
they are
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


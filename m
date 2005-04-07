Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVDGNAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVDGNAL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVDGNAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:00:11 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:1505 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262451AbVDGNAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:00:03 -0400
Date: Thu, 7 Apr 2005 14:00:07 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk tree] DRM add a version check.. for 2.6.12 (distro kernel
 maintainers + drm users plz read also...)
In-Reply-To: <20050407125345.GI3858@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.58.0504071357020.25035@skynet>
References: <Pine.LNX.4.58.0503281236330.27073@skynet>
 <20050407114933.GH3858@mea-ext.zmailer.org> <Pine.LNX.4.58.0504071334560.25035@skynet>
 <20050407125345.GI3858@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> My lattest runs were with 2 days old FC development (a.k.a. "bleeding edge")
> environment with  xorg-11-** of same age.  Then I noticed that these DRM
> patches didn't make it into  kernel-smp-2.6.11-1.1226_FC4.i686.rpm,
> and I made 2.6.12-rc2 -- just in case it had fixed the problem...
>

well these patches shouldn't really affect it..

> Could the card-lockups be recovered in a bit nicer way ?
> (And detected, too!)

In theory yes, but there isn't really anything you can do except reboot,
as usually the CP (command processor) is hung, and you have to do a full
GPU reset, I can't imagine X or Linux consoles surviving it too well...
ATI have a VPU Recover in their windows driver which does it.. but they
know their cards a bit better than we do..

it might be worth turning Render acceleration off Option "RenderAccel"
"No" in xorg.conf and see if it gets any stabler...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG


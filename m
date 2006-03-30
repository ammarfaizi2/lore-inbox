Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWC3V7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWC3V7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWC3V7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:59:21 -0500
Received: from holly.csn.ul.ie ([193.1.99.76]:48025 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751023AbWC3V7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:59:20 -0500
Date: Thu, 30 Mar 2006 22:59:10 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [git pull] DRM changes for 2.6.17
In-Reply-To: <Pine.LNX.4.64.0603301232050.27203@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603302255530.6981@skynet.skynet.ie>
References: <Pine.LNX.4.64.0603300650180.24125@skynet.skynet.ie>
 <Pine.LNX.4.64.0603301232050.27203@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you describe what that means more?
>
> Does it mean that people with old X versions will lose hw acceleration?
> For which chips?

No it means people with old X versions won't try to enable hw accel on 
cards that their X.org doesn't suppport...

The X.org drivers with respect to r300 drivers are highly experimental and 
enabled DRI on r300 by default before they should, when I added the r300 
PCI IDs as I tried last time, lots of people crashed and you backed out 
the changes... so now the kernel isn't going to to trigger those problems, 
as all of the new r300 class cards require using a new Xorg driver to 
enable DRI..

Its the only way I can think off to get the r300 PCI ids into the kernel 
and not break current systems... there is nothing I can do in the DRM to 
fix the Xorg DDX stupidity..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG


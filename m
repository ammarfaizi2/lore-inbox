Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUKERTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUKERTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 12:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbUKERTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 12:19:33 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:13735 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262728AbUKERTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 12:19:12 -0500
Date: Fri, 5 Nov 2004 17:19:11 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@gmail.com>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: 2.6.10-rc1-mm3: drm_ati_pcigart_{init,cleanup} multiple definition
In-Reply-To: <20041105165220.GD1295@stusta.de>
Message-ID: <Pine.LNX.4.58.0411051716200.15111@skynet>
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105165220.GD1295@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ...
>   LD      drivers/char/drm/built-in.o
> drivers/char/drm/radeon.o(.text+0x120): In function `drm_ati_pcigart_init':
> : multiple definition of `drm_ati_pcigart_init'
> drivers/char/drm/r128.o(.text+0x120): first defined here
> drivers/char/drm/radeon.o(.text+0x350): In function `drm_ati_pcigart_cleanup':
> : multiple definition of `drm_ati_pcigart_cleanup'
> drivers/char/drm/r128.o(.text+0x350): first defined here
> make[3]: *** [drivers/char/drm/built-in.o] Error 1


The latest drm-2.6 tree avoids this I'm working with Jon to see if this
solution is suitable..

It is a leftover from the templated tree, building into the kernel wasn't
noticed until my merge....

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbUKERds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbUKERds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 12:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbUKERds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 12:33:48 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:34423 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262727AbUKERdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 12:33:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fFy/Hb17vOz2UGUBiV0faurAunZsvjySHIffRYto5pPKbxeq2daSjw35Zj/CMyitBX5IzUPZ+tgY6UDzJHHDNEmEl1PXeYTKKcXxJjC3iBtGycja3cR4aCKr4FCEEl6tU8xybA5w67fzJVXWRa2WBBne/QSAvSNSZD461Pnq+iA=
Message-ID: <9e47339104110509335ee0d82b@mail.gmail.com>
Date: Fri, 5 Nov 2004 12:33:46 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: 2.6.10-rc1-mm3: drm_ati_pcigart_{init,cleanup} multiple definition
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0411051716200.15111@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041105001328.3ba97e08.akpm@osdl.org>
	 <20041105165220.GD1295@stusta.de>
	 <Pine.LNX.4.58.0411051716200.15111@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004 17:19:11 +0000 (GMT), Dave Airlie <airlied@linux.ie> wrote:
> >   LD      drivers/char/drm/built-in.o
> > drivers/char/drm/radeon.o(.text+0x120): In function `drm_ati_pcigart_init':
> > : multiple definition of `drm_ati_pcigart_init'

I put a quick fix for this into DRM CVS that moves the two functions
into the drm-core module. Let me know if you want to do anything more
complicated.

-- 
Jon Smirl
jonsmirl@gmail.com

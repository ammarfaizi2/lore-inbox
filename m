Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbULNVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbULNVqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbULNVqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:46:03 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:6536 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261667AbULNVpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:45:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=o/v8e7jzndSI0w/vcnI1yGhnv5HWQmZbFpTiMuG5zgRnKz/PXoc6iMTtrQu24cL38NmQzr1/C8dK77RiTZXn7/90xocRCqTGLHropj3qAfdeqAE8wFid/1d/0dmyisyiBroqx6Nqg3D7DFLK85ks10sC/qFpHHTvVzdUvJ+4WUM=
Message-ID: <9e4733910412141345380559da@mail.gmail.com>
Date: Tue, 14 Dec 2004 16:45:43 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] fix ROM enable/disable in r128 and radeon fb drivers
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200412141256.21143.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412141256.21143.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These drivers should be using the new ROM API in the PCI driver
instead of manipulating the ROMs directly. Now that the ROM API is in
the kernel all direct use of PCI_ENABLE_ROM should be removed. There
are about thirty places in the kernel doing direct access. Kernel
janitors would probably be a good place to track removing
PCI_ENABLE_ROM.

I'm tied up taking care of premature baby twins so it is going to be
quite a while until I can work on things like this.

-- 
Jon Smirl
jonsmirl@gmail.com

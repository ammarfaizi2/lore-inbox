Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbUKIXSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbUKIXSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbUKIXSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:18:20 -0500
Received: from mproxy.gmail.com ([216.239.56.241]:27405 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261749AbUKIXSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:18:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XA8o9hBvaclW3SC0fbEYPYJApC9zO9sfIiKMg2anuCqxSsckK3QM4bKL4Q0QMNOKht4UEEAVJyXlphkyMWU7zx8La4MilXVC65rrNqsGMZIjP5sm9QVLAsqDIxiyP2Gjv3/dMfJm4esSfjAJ1MCcwuq03Vdc38xsbcPugUxiIZk=
Message-ID: <21d7e997041109151833ef1d90@mail.gmail.com>
Date: Wed, 10 Nov 2004 10:18:12 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Stefano Rivoir <s.rivoir@gts.it>
Subject: Re: 2.6.10-rc1-mm4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200411091802.16386.s.rivoir@gts.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041109074909.3f287966.akpm@osdl.org>
	 <200411091802.16386.s.rivoir@gts.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> A glxgears causes Xorg to get immediately out; nothing very notable in the
> logs, except for
> 
> Nov  9 17:57:09 nbsteu kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init
> called without lock held
> Nov  9 17:57:09 nbsteu kernel: [drm:drm_unlock] *ERROR* Process 4999 using
> kernel context 0
> 
> in the syslog.
> 
> Note that everything works fine with 2.6.10-rc1-bk18.
> Attached, lspci and .config.

Can you put up a dmesg as well? I think it might be something to do
with DRM core in-kernel, but AGP and card driver as a module,

I wonder should I change the Kconfig for CONFIG_DRM so we have a
CONFIG_DRM_CORE so old configs don't break silently....

Dave.

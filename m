Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbUKNJ0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbUKNJ0P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 04:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbUKNJ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 04:26:15 -0500
Received: from mproxy.gmail.com ([216.239.56.242]:37185 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261272AbUKNJYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 04:24:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aNAq5OKssLTrtJkYtR39kQ1sC9v5TwHAawvgAbmt1NeuWtIGvjeHJE7qQI9gjFitXRG8SklgN8DyCiu2dn2kgtEKhD/dsExP7QeEV7eXDS78COJh42FkT1yR+t8WFiTFjEg4ounIz6aM9xXNv/w1r5ybzMzSzCoVZ+j6lAUUlcM=
Message-ID: <21d7e99704111401242e713fb4@mail.gmail.com>
Date: Sun, 14 Nov 2004 20:24:49 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Stas Sergeev <stsp@aknet.ru>
Subject: Re: 2.6.10-rc1-mm5
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41967669.3070707@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41967669.3070707@aknet.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 2. Radeon DRM driver stopped working.
> dmesg says:
> ---
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected AMD Irongate chipset
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: AGP aperture is 64M @ 0xe8000000
> [drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
> [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> [drm:drm_unlock] *ERROR* Process 3124 using kernel context 0
> ---
>

You are building AGP as a module with DRM as a built-in ,the DRM
cannot use the AGP if it is not built in also, I think the latest DRM
bk tree should enforce this I'm not sure if -mm5 has  the patches in
it or not...

I'm going to add something in the DRM debug to state whether AGP is in
use or not ..

Dave.

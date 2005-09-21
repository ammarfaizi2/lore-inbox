Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVIUKcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVIUKcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 06:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVIUKcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 06:32:31 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:2260 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750777AbVIUKcb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 06:32:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KY3whulySkAewzyvu6T6BNdNgZcmgm9A4fYKTF3ZyZuWMbZNuLa4vS/8NESKDBJ2nZgcNw8HtEyIN98DccxoRKAv39i9iRl7G8uVIqjFOLpSu1VcRKaQr8PsiWne6gVrsVyjmfpZec9QDyi1EMNDwSBJEKGiUvyDRHMrLia5z2Y=
Message-ID: <21d7e9970509210332f01458c@mail.gmail.com>
Date: Wed, 21 Sep 2005 20:32:30 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Athar Hameed <06020051@lums.edu.pk>
Subject: Re: In-kernel graphics subsystem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2CB9FE03B6DBB54AAD7193A44499D6242C9B96@satluj1.lums.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <AcW+QBo8uJ+XV7vHTZWR1mo7M5VcNg==>
	 <2CB9FE03B6DBB54AAD7193A44499D6242C9B96@satluj1.lums.edu.pk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> We are a group of three undergrad CS students, almost ready to start our senior project. We have this idea of integrating a graphics subsystem with the kernel and doing away with the X server. We are not really sure if this is a wise thing to do. It hasn't been done before. Your comments on this idea will be very helpful.
>
>

This isn't a good idea, the whole idea of dumping the X server has
been done to death, you might notice we still have an X server... as
mentioned fbui and also DirectFB does a lot of things (not all
in-kernel....)

What might be an interesting side project that is fairly self
contained would be a userspace console with full support for
international languages and Unicode/UTF-8 rendering, using
freetype/xft code. Jon Smirl suggests this in his
http://www.freedesktop.org/~jonsmirl/graphics.html paper and I've
thought it would be an interesting idea to implement at some point,

You could sit it on top of OpenGL or directly on the drm/fbdev layers
(probably a bit harder) an OpenGL rendered console would be a good
enough start I suppose...

Dave.

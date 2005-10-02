Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVJBHIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVJBHIn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 03:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVJBHIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 03:08:43 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:19067 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751000AbVJBHIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 03:08:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=F+O2eep6mu4Ta81ltJJoRR8SkAmxa55En7RXoTdkEV/2KqTHn1CeTFZudgXxFZfZO/KAraQcPBzd113T9Vs9OVh6JOmb/0E2hiEAymV1M4/t2Dd6CEulSbnTRz2j8/k0ShiQ8QVUzJ0zA5wpjLOmpoLJ6XAc5e7z+ZTayNYrG7A=
Message-ID: <433F8774.6000301@gmail.com>
Date: Sun, 02 Oct 2005 15:08:36 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] nvidiafb: PPC & mode setting fixes (#2)
References: <1128225462.8267.24.camel@gaston> <1128232186.8267.31.camel@gaston>
In-Reply-To: <1128232186.8267.31.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> (This version removes a useless bit that slipped in the previous one)
> 
> This patch fixes a couple of things in nvidiafb:
> 
>  - The code for retreiving the mode from Open Firmware was broken. It
> would crash at boot and was copied from the old rivafb code that didn't
> work very well (I'll update rivafb too one of these days).

What do you think of making EDID retrieval from the OF generic?  Or is
it too much hassle?

> 
>  - The mode setting code produced weird results on the 5200 card in the
> iMac G5 here. X "nv" code works fine though. After comparing them, I
> found out that we aren't really manipulating some VGA bits the same way
> and X code seemed better, so I slightly changed the mode setting to do
> the same and that fixed the problem. (The display was strangely shifted
> with garbage in the margin but not on all lines, and not in bpp 32)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks for the fix :-)  

Acked-by: Antonino Daplas <adaplas@pol.net>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVCVBLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVCVBLO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVCVBJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:09:57 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:21689 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262256AbVCVBHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:07:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lmAvxJq1W15p8pBSbvqVS9byFBWCujf+j0r3YnE1ZpONOJGZcX2DJoPk1AObsGF5AMc6wMaqRwQ7/qIXmnpcI8t0BFjrcadE1+KuNrlHeHX++CbnBoSsfJJJ9o/TIha0w1E1WfCrFNeW93SKBjtw3Amu8iaiwAf4Xo9g/aTTdRw=
Message-ID: <423F6FC9.4080807@gmail.com>
Date: Mon, 21 Mar 2005 20:07:21 -0500
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: i830 DRM problems
References: <422C5A25.3000701@ens-lyon.org>	<21d7e99705031115075e4378ed@mail.gmail.com> <20050321151453.695c73e2.akpm@osdl.org> <423F5A0A.7060307@ens-lyon.org>
In-Reply-To: <423F5A0A.7060307@ens-lyon.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry about that, we start to talk about it in private with Dave.
> But, I did not really it since Keenan Pepper told me it was due
> to a bug in the XFree 4.3 driver.
> I am now using Xorg and didn't see any DRM problem since.
> However, I can't confirm that my bug was surely due to the XFree driver 
> and not to the kernel driver since Xorg uses i915 instead of i830.
> Keenan, do you have details ?

Yes, I talked to Alan Hourihane about it and he identified it as a 
memory allocation bug in the i810 X server driver. It's not related to 
DRI - it happens even with DRI turned off - so it wouldn't matter which 
DRM module is being used.

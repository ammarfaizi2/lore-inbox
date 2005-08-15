Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbVHOXSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVHOXSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVHOXSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:18:39 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:32286 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932560AbVHOXSi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:18:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kWW0MLuonLp67wVpMbR+yKt1zJTnDFX/p0+wvtQyaAgN217v25lXLoNDcg2BHBFopg36IuwheXTTldV47HWdkT352jMjgro0M8XZ6Oz1YQXTHNWzvrGh64KDVHtNbndiOsikskJqvoROzeV6Usjg0pDV+zp2ZN9bkdbbTOXNEBg=
Message-ID: <21d7e99705081516182e97b8a1@mail.gmail.com>
Date: Tue, 16 Aug 2005 09:18:36 +1000
From: Dave Airlie <airlied@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: rc6 keeps hanging and blanking displays - bisection complete
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20050815221109.GA21279@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
	 <20050805104025.GA14688@aitel.hist.no>
	 <21d7e99705080503515e3045d5@mail.gmail.com>
	 <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no>
	 <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org>
	 <43008C9C.60806@aitel.hist.no>
	 <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
	 <20050815221109.GA21279@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'm a little surprised, as a ppc64 fix theoretically shouldn't matter for
> x86_64? But perhaps they share something?

My guess is that it is maybe the DRM changes that have done it... the
32/64-bit code in 2.6.13-rc6 may have issues, but they've been tested
on a number of configurations (none of them by me... I can't test what
I don't have...)

Can you do me a favour and check 2.6.13-rc6 with the git-drm.patch from -mm?

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc5/2.6.13-rc5-mm1/broken-out/git-drm.patch

If this is a 32/64-bit issue I think that patch might help, I'm not
convinced I can't see how the DRM would ever start blanking the
screen, it doesn't have any code in that area at all.. but stranger
things have surprised me...

Is there any difference in your Xorg.0.log files before/after this...

There is also an issue at:
http://bugme.osdl.org/show_bug.cgi?id=4965

which was caused by the pci assign resources patch on x86... I'm not
sure if this is similiar..

Dave.

Dave.

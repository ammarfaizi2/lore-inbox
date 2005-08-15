Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbVHOXY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbVHOXY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVHOXY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:24:27 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:59039 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932573AbVHOXY0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:24:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rQLWMvHPKbmQa7qsgb64sFhuNi4CNDDMbcRfpWfY9SekTtEBYQab8oS7Y6sWHZRdjQJeNoOvJeA8PoYRtoZuy6Z/ZhtkZV044kxPlCgvnxZQ8rE20OOHqSXttJhKtheqgzCL6HCpzrUeostUq0XIgdB5FfBFSQKxcN2FsTKEKUo=
Message-ID: <21d7e99705081516241197164a@mail.gmail.com>
Date: Tue, 16 Aug 2005 09:24:25 +1000
From: Dave Airlie <airlied@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: rc6 keeps hanging and blanking displays - bisection complete
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <21d7e99705081516182e97b8a1@mail.gmail.com>
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
	 <21d7e99705081516182e97b8a1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm a little surprised, as a ppc64 fix theoretically shouldn't matter for
> > x86_64? But perhaps they share something?
> 
> My guess is that it is maybe the DRM changes that have done it... the
> 32/64-bit code in 2.6.13-rc6 may have issues, but they've been tested
> on a number of configurations (none of them by me... I can't test what
> I don't have...)
>

Actually after looking back 2.6.13-rc4-mm1 which you say works doesn't
contain any of the later 32/64-bit changes.. so maybe you can try just
applying the git-drm.patch from that tree to see if it makes a
difference...

I'm getting less and less sure this is caused by the drm, (have you
built with DRM disabled completely??)

Do you have any fb support in-kernel (I know you might have answered
this already but I'm getting a bit lost on this thread...)

Dave.

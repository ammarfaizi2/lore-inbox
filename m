Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWIOIGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWIOIGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWIOIGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:06:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:24458 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751361AbWIOIGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:06:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V41pB8EC9v9wypn7Kne9e/zAarjFNHJ1vhXaQyfqRs85iWhIGB7b8cD020cfIJ72/Sz/OY49liJFWVrnkWj0MWI+kDI8u92t/U9nGqGeSTJ3LQR5+hn9Xlhx084Bsw5Va1OYWw1nltnMaRqOI5Ti5R2113FGIwm9X356/vYJEz4=
Message-ID: <6bffcb0e0609150106u1e97020bn5788f864e68ff045@mail.gmail.com>
Date: Fri, 15 Sep 2006 10:06:48 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "David Chinner" <dgc@sgi.com>
Subject: Re: [xfs-masters] Re: 2.6.18-rc6-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       xfs-masters@oss.sgi.com, "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <20060915055831.GP3034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0609130243y776492c7g78f4d3902dc3c72c@mail.gmail.com>
	 <450914C4.2080607@gmail.com>
	 <6bffcb0e0609140150n7499bf54k86e2b7da47766005@mail.gmail.com>
	 <20060914090808.GS3024@melbourne.sgi.com>
	 <6bffcb0e0609140229r59691de5i58d2d81f839d744e@mail.gmail.com>
	 <6bffcb0e0609140303n72a73867qb308f5068733161c@mail.gmail.com>
	 <6bffcb0e0609141001ic137201p6a2413f5ca915234@mail.gmail.com>
	 <20060915025745.GM3034@melbourne.sgi.com>
	 <20060914204801.e37a112b.akpm@osdl.org>
	 <20060915055831.GP3034@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/06, David Chinner <dgc@sgi.com> wrote:
> On Thu, Sep 14, 2006 at 08:48:01PM -0700, Andrew Morton wrote:
> > "BAD" is a bisection point, as per
> > http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt.  So
> > just 2.6.18-rc6+origin.patch exhibits the failure.  That is mainline.
>
> Ah - thanks for explaining that for me, Andrew.
>
> Michal, there were several XFS fixes (4, I think) that went into -rc7.  If
> -rc6 fails and -rc7 doesn't then we need to check if one of those fixes is
> responsible.

As I said before "I was wrong" (I use lockdep only with -mm kernels).

> The crash doesn't match any of the symptoms we've seen from them,
> but it's worth checking.

http://www.ussg.iu.edu/hypermail/linux/kernel/0608.1/1202.html

The problem with this bug is "bad interaction" between lockdep and
XFS. (I forgot about this probably because lockdep was broken for me
in 2.6.18-rc5-mm* - and previous bug appeared while mounting XFS, not
umounting).

2006-07-03 locdep was merged
2006-07-28 - 2006-08-10 a few XFS fixes

So I guess that binary search won't solve this mystery.

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> Principal Engineer
> SGI Australian Software Group
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)

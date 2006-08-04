Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161214AbWHDOCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161214AbWHDOCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbWHDOCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:02:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:63598 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161212AbWHDOCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:02:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d3IO7nASKdbFN1p8XDZ+4D64zoLm212YCnMpvxz7jB85LTBkZu4fDcIxmuvUhFRguYOyHsj6R2U8dumr2+vOU4LihUeRrq/qN1Yum9W0SR67/g/lLbBba+3UXPmxPbUx0T+b8+qo4cQdjb8kQjYXuuIdUUHUoINwQyjCWXkwWCQ=
Message-ID: <6e0cfd1d0608040702h15371d31q1c3d1c305c3da424@mail.gmail.com>
Date: Fri, 4 Aug 2006 16:02:43 +0200
From: "Martin Schwidefsky" <schwidefsky@googlemail.com>
To: "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64 aliasing problem)
Cc: johnstul@us.ibm.com, akpm@osdl.org, zippel@linux-m68k.org,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, ak@muc.de
In-Reply-To: <20060804.005352.128616651.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6e0cfd1d0607310336o355693a5l939db098b9210d81@mail.gmail.com>
	 <20060801.234422.25910237.anemo@mba.ocn.ne.jp>
	 <6e0cfd1d0608020550k7ae2c44dg94afbe56d66b@mail.gmail.com>
	 <20060804.005352.128616651.anemo@mba.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I see.  Then how about this?
>
>
> [PATCH] cleanup do_timer and update_times
> ...

Good start, now you only have the change the 30+ calls to do_timer in
the various architecture backends.

-- 
blue skies,
  Martin

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319848AbSINDbd>; Fri, 13 Sep 2002 23:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319849AbSINDbd>; Fri, 13 Sep 2002 23:31:33 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:8205 "EHLO mx5.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S319848AbSINDbd>;
	Fri, 13 Sep 2002 23:31:33 -0400
Date: Sat, 14 Sep 2002 11:35:32 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Werner Almesberger <wa@almesberger.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption (fwd)
In-Reply-To: <20020914000159.A3352@almesberger.net>
Message-ID: <Pine.LNX.4.42.0209141130250.30528-100000@silk.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/14/2002
 11:36:15 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/14/2002
 11:36:21 AM,
	Serialize complete at 09/14/2002 11:36:21 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2002, Werner Almesberger wrote:

> So, assuming the problem is indeed the kernel overwriting initrd,
> there are three things you can do to avoid this:
>
>  - use a smaller initrd (they were never meant to be quite
>    *that* big anyway :-)

First, thanks for replying.

Now, I used "strip" to strip everything including /lib/lib* and managed to
reduced from 24MB to 12MB uncompressed (8MB to 5MB compressed), and
avoided the booting problem. Stripping /lib/lib*.so* was the answer!

Thanks,
Jeff.



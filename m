Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318895AbSIIUeV>; Mon, 9 Sep 2002 16:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318896AbSIIUeV>; Mon, 9 Sep 2002 16:34:21 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:6337 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318895AbSIIUeT>;
	Mon, 9 Sep 2002 16:34:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 22:41:30 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jesse Barnes <jbarnes@sgi.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       "'David S. Miller'" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <019f01c25826$c553f310$9e10a8c0@IMRANPC> <E17oTES-0006qj-00@starship> <3D7CF93A.972FCC8D@digeo.com>
In-Reply-To: <3D7CF93A.972FCC8D@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oVLe-0006uT-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 21:40, Andrew Morton wrote:
> We need a general-purpose "read or write these pages to this blockdev"
> library function.

I thought bio was supposed to be that.  In what way does it not suffice?
Simply because of not having a suitable wrapper?

> For mtdblk, LVM1/LVM2 and probably swapper_space.
> With that we can remove the block IO stuff from kiovecs.  And convert
> the other drivers to use get_user_pages() directly into an ad-hoc private
> page array.  Those things would allow kiovecs/kiobufs to be retired.

As far as pressing generic_direct_IO into use for this purpose goes, why
not forget about that (crufty looking) layer and sit directly on top of
bio?

-- 
Daniel

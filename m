Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUIMMKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUIMMKX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUIMMKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:10:23 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:38654 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S266467AbUIMMKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:10:21 -0400
Date: Mon, 13 Sep 2004 13:10:20 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: graphics futures - untoasted..
Message-ID: <Pine.LNX.4.58.0409131224590.5648@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	Okay so now that everybody has nearly all the flames out of their
systems (including myself - I ran a half marathon to take a break :-),

Alan/Linus idea is probably going to be what happens so I thought I'd give
it a fair chance and try and see why we need it...

So what are peoples view on doing the following to the radeon driver after
Alan has showed the code...

We use Alan's framework to setup 3 drivers, radeon common, fb and dri..

The common code is things both fb and dri want to do right now, at the
moment, they both write mmio/plls, have info about card capabilties, wait
for card sync, into the once place, and have the the fb and dri contain
all the unshared code, so we don't get duplication and we don't get
bloating of the fb or drm,

Now I know someone might say that we probably don't need a common layer,
that with Alans scheme the fb can call the drm and the drm the fb, but if
this happens then you start mandating the fb be loaded for certain DRM
things and vice-versa, which to me means you may as well merge them as
otherwise the drivers will start losing features if one side is loaded
without the other and if you have to have both loaded, why wouldn't you
merge em... also having two copies of the really common code is a bit
pointless..

I'll probably do an i830 also, there isn't any fbdev for 2.6 for the i830
at all, so I probably can't step on too many toes :-)

Anyways when Alan posts a working patch, I'll try and come up with
something soon after....

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267917AbUGaJNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267917AbUGaJNz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267919AbUGaJNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:13:55 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:53135 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267917AbUGaJNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:13:53 -0400
Date: Sat, 31 Jul 2004 10:13:19 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.sf.net
Subject: drm - first steps towards 64-bit correctness..
Message-ID: <Pine.LNX.4.58.0407310940540.6368@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
        As a first step towards sorting getting the DRM into shape for
proper use on 32/64-bit systems, I'd like to sort out all the type
definitions in drivers/char/drm/drm.h, this file is also included in
userspace and BSD builds...

After reading the thread "32/64bit issues in ioctl struct passing" on
dri-devel, I'm still not 100% sure what we need to do, I just know we to
do something sooner rather than later!! we are getting more and more
32/64-bit users everyday....
While avoiding breakage of current users is "a good thing" I'm not sure it
overrides "getting it right", at the moment mixed 32/64-bit is broken for
most cards anyways... I'd like to try and not break pure-32 or pure-64 bit
setups alright but I think pure-64 bit might take some collateral damage
:-(..

I've looked across the SuSE patch[1] for 64-bit, but it looks like it will
add complexity and making future maintenance nightmareish...

We do need to sort this out ASAP, and I also would like to say I'm
probably not the best person to do the work, I've no non-32bit hardware to
test this stuff on, I've little 32/64 mixed environment experience,
everytime I think I've grasped the issues I dig a bit further :-), though
I also believe this is the single biggest issue with the DRM currently (as
the maintainer..)

Regards,
Dave.

[1] http://marc.theaimsgroup.com/?l=dri-devel&m=109040871011904&w=2

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


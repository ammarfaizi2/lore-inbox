Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbUKJBQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUKJBQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUKJBQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:16:15 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:55507 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261816AbUKJBQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:16:12 -0500
Date: Wed, 10 Nov 2004 01:16:10 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: kconfig/build question..
Message-ID: <Pine.LNX.4.58.0411100110170.1637@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've come across something that I'm not sure Kconfig can do but I'll
explain what I need and see what others can come up with...

The DRM has a weak dependency on AGP, it does not require AGP for all
situations but can use it in most...

So what I want to do and what I think Kbuild can't do is:

if CONFIG_AGP=n then CONFIG_DRM can be n,m,y
if CONFIG_AGP=m then CONFIG_DRM can be m but not y
if CONFIG_AGP=y then CONFIG_DRM can be m,y

This also needs to work for oldconfigs if it can be enforced, so someone
who has a valid config now of CONFIG_AGP=m, CONFIG_DRM=y will be
questioned...

I'm thinking I could change the name of CONFIG_DRM to CONFIG_DRM_CORE and
just use the default rules, if the worst comes to the worst...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUH1CRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUH1CRl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 22:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUH1CRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 22:17:41 -0400
Received: from lucas.isthe.com ([64.81.78.74]:19877 "HELO asthe.com")
	by vger.kernel.org with SMTP id S266204AbUH1CRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 22:17:39 -0400
From: <lkml-mail@asthe.com>
To: <linux-kernel@vger.kernel.org>
Date: Fri, 27 Aug 2004 19:16:18 -0700
Message-ID: <74c68b63c43337d4366c367b282f4b91916d61ff@asthe.com>
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have heard in several comments to the effect:

        pwc us useless without pwcx

While we don't want/intend to take sides in the pwcx/kernel dispute,
we want to make it clear that these claims are simply not true.
The pwc driver is very useful without pwcx.

The LavaRnd project uses webcams with lens caps an entropy sources
for generating random numbers (see http://www.lavarnd.org).  One of
our reference webcams is the Logitech QuickCam 3000 Pro - pwc730 webcam
(see http://www.lavarnd.org/developer/pwc730.html).

    [[You may have heard of the SGI classic lavarand that used
      Lava Lite(R) lamps to generate seeds.  LavaRnd generates
      random numbers by way of webcams instead of Lava Lite lamps.
      See: http://www.lavarnd.org/news/lavadiff.html for differences]]

LavaRnd uses only the pwc module.  In fact our hotplug script install
script does an rmmod of the pwcx module.  This is because we discovered
that the pwcx module reduced the entropy that the webcams provided.
The pwcx module made the webcam a poorer entropy source.

Please do not remove the pwc module from the Linux kernel.  Our users
depend on pwc without pwcx.

We (LavaRnd) do not want to take sides in this PWC/PWCX kernel dispute. If
this posting appears that way, then we apologize.  It is our hope
that some solution that is satisfactory to both sides can be reached.

We would be happy to discuss ways that the pwc might be maintained
in the linux kernel.  If we can help, please ask us (see
http://www.lavarnd.org/about-us/contact-us.html for our EMail address).

chongo (Landon Curt Noll) /\oo/\

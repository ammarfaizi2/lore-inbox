Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVBKRvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVBKRvh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVBKRvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:51:35 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:43767 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262241AbVBKRtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:49:07 -0500
Message-Id: <200502111749.j1BHn4pe021145@localhost.localdomain>
To: Matt Mackall <mpm@selenic.com>
cc: Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2 
In-reply-to: Your message of "Fri, 11 Feb 2005 00:25:36 PST."
             <20050211082536.GF15058@waste.org> 
Date: Fri, 11 Feb 2005 12:49:04 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.197.126.48] at Fri, 11 Feb 2005 11:49:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>RT-LSM introduces architectural problems in the form of bogus API. And

that may be true of LSM, but not RT-LSM in particular. RT-LSM doesn't
introduce *any* API whatsoever - it simply allows software to call
various existing APIs (mostly from POSIX) and have them not fail as
result of not being root and/or not running on a capabilities-enabled
kernel without the required caps.

No audio apps "use" RT-LSM in any way - it just lets them do things
they otherwise could not do. And all the alternatives to RT-LSM have
this feature as well - controlling rlimits won't be done by the audio
apps, but by some part of the security infrastructure.

>it's implemented as an LSM is meaningless if Redhat and SuSE ship it
>on by default.

We haven't encouraged anyone to ship anything with it on by default:
the idea is for the module to be present and usable, not turned on.

--p


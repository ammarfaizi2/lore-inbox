Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbTIHOaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTIHOaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:30:24 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:57730 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262436AbTIHOaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:30:20 -0400
Subject: Re: [CFT][PATCH] new scheduler policy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Haoqiang Zheng <hzheng@cs.columbia.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Nick Piggin <piggin@cyberone.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Mike Galbraith <efault@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F5C9010.1080607@cs.columbia.edu>
References: <3F4182FD.3040900@cyberone.com.au>
	 <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>
	 <20030820021351.GE4306@holomorphy.com> <3F4A1386.9090505@cs.columbia.edu>
	 <3F4A172F.8080303@cyberone.com.au> <3F4A272F.8000602@cs.columbia.edu>
	 <20030902142552.GG1358@openzaurus.ucw.cz>
	 <1063028436.21084.30.camel@dhcp23.swansea.linux.org.uk>
	 <3F5C9010.1080607@cs.columbia.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063031334.21050.44.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 15:28:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 15:20, Haoqiang Zheng wrote:
> How do you define "priority inversion" if the app is remote?

You have to know the dependancies for the entire system, its nearly
impossible to do. Once you have the apps also waiting for each other and
for direct communications (eg via a database or a shared service) life
gets fun. 

For local apps one thing that has been suggested and some microkernels
have played with is a syscall that basically is "send this message and
donate the rest of my timeslice to.."



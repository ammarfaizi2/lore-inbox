Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbUKQQ2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUKQQ2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbUKQQ2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:28:14 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:56804 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262368AbUKQQ2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:28:11 -0500
Subject: Re: [patch] prefer TSC over PM Timer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
References: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100705099.420.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 15:25:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-16 at 00:23, dean gaudet wrote:
> i've heard other folks have independently run into this problem -- in fact 
> i see the most recent fc2 kernels already do this.  i'd like this to be 
> accepted into the main kernel though.

IMHO it was a mistake to make this change in FC2.

> the x86 PM Timer is an order of magnitude slower than the TSC for 
> gettimeofday calls.  i'm seeing 8%+ of the time spent doing gettimeofday 
> in someworkloads... and apparently kernel.org was seeing 80% of its time 
> go to gettimeofday during the fc3-release overload.  PM timer is also less 
> accurate than TSC.

Nobody guarantees that the TSC is clocked at the same rate per CPU and
several power management schemes break it. I see it break on my Thinkpad
600 and its one reason I have to replace the FC kernel with a 2.6-ac
kernel on that system.

Is gettimeofday supposed to return the right value or be fast ?


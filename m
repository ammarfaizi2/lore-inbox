Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265035AbUF1Pj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265035AbUF1Pj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUF1Pj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:39:26 -0400
Received: from ktown.kde.org ([131.246.103.200]:8898 "HELO ktown.kde.org")
	by vger.kernel.org with SMTP id S265035AbUF1PjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:39:21 -0400
Date: Mon, 28 Jun 2004 17:39:20 +0200
From: Oswald Buddenhagen <ossi@kde.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
Message-ID: <20040628153920.GA21985@ugly.local>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1088363821.1698.1.camel@teapot.felipe-alfaro.com> <200406272128.57367.mbuesch@freenet.de> <1088373352.1691.1.camel@teapot.felipe-alfaro.com> <Pine.LNX.4.58.0406281013590.11399@kolivas.org> <1088412045.1694.3.camel@teapot.felipe-alfaro.com> <40DFDBB2.7010800@yahoo.com.au> <1088423626.1699.0.camel@teapot.felipe-alfaro.com> <40E00AEA.4050709@kolivas.org> <20040628150343.GD2478@ugly.local> <40E03713.9010208@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E03713.9010208@kolivas.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 01:19:47AM +1000, Con Kolivas wrote:
> | i think using nice for both cpu share and latency is broken by design ...
> | a typical use case on my system: for real-time tv recording i need
> | mencoder to get some 80% of the cpu time on average. that means i have
> | to nice -<something "big"> it to prevent compiles, flash plugins running
> | amok, etc. from making mencoder explode (i.e., overrun buffers). but that
> | entirely destroys interactivity; in fact the desktop becomes basically
> | unusable.
> 
> You want mencoder to use 80% of your cpu
>
yes.

> and be scheduled fast enough to not drop frames.
>
no. a) because the grabber runs in a separate thread that uses hardly
any cpu and should be auto-classified as interactive and b) because the
bttv driver can buffer a few frames in the kernel anyway.

greetings

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.

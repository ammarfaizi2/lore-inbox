Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264998AbUF1PDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264998AbUF1PDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbUF1PDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:03:47 -0400
Received: from ktown.kde.org ([131.246.103.200]:22171 "HELO ktown.kde.org")
	by vger.kernel.org with SMTP id S264998AbUF1PDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:03:44 -0400
Date: Mon, 28 Jun 2004 17:03:43 +0200
From: Oswald Buddenhagen <ossi@kde.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
Message-ID: <20040628150343.GD2478@ugly.local>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200406251840.46577.mbuesch@freenet.de> <200406261929.35950.mbuesch@freenet.de> <1088363821.1698.1.camel@teapot.felipe-alfaro.com> <200406272128.57367.mbuesch@freenet.de> <1088373352.1691.1.camel@teapot.felipe-alfaro.com> <Pine.LNX.4.58.0406281013590.11399@kolivas.org> <1088412045.1694.3.camel@teapot.felipe-alfaro.com> <40DFDBB2.7010800@yahoo.com.au> <1088423626.1699.0.camel@teapot.felipe-alfaro.com> <40E00AEA.4050709@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E00AEA.4050709@kolivas.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 10:11:22PM +1000, Con Kolivas wrote:
> The design of staircase would make renicing normal interactive things
> -ve values bad for the latency of other nice 0 tasks s is not
> recommended for X or games etc. Initial scheduling latency is very
> dependent on nice value in staircase. If you set a cpu hog to nice -5
> it will hurt audio at nice 0 and so on.
>
i think using nice for both cpu share and latency is broken by design ...
a typical use case on my system: for real-time tv recording i need
mencoder to get some 80% of the cpu time on average. that means i have
to nice -<something "big"> it to prevent compiles, flash plugins running
amok, etc. from making mencoder explode (i.e., overrun buffers). but that
entirely destroys interactivity; in fact the desktop becomes basically
unusable.

greetings

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.

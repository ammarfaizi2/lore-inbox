Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbUKLIFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbUKLIFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 03:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUKLIFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 03:05:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30852 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262486AbUKLIFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 03:05:50 -0500
Date: Fri, 12 Nov 2004 09:03:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] Fix sysdev time support
Message-ID: <20041112080348.GD6307@atrey.karlin.mff.cuni.cz>
References: <1100213485.6031.18.camel@desktop.cunninghams> <1100213798.6031.31.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100213798.6031.31.camel@desktop.cunninghams>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Add an extra parameter to get_cmos_time and to arch specific routines,
> allowing the user to specify whether we should wait for the beginning of
> a new second, or simply ensure that the time returned is accurate.

Well, I'd introduce __get_cmos_time() which is fast and implement
get_cmos_time() using fast version if that is possible. That solves
"change all callers" problem...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

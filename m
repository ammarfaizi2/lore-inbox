Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVBKTmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVBKTmy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 14:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVBKTmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 14:42:53 -0500
Received: from waste.org ([216.27.176.166]:21635 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262320AbVBKTmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 14:42:52 -0500
Date: Fri, 11 Feb 2005 11:42:33 -0800
From: Matt Mackall <mpm@selenic.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211194233.GL15058@waste.org>
References: <20050211082536.GF15058@waste.org> <200502111749.j1BHn4pe021145@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502111749.j1BHn4pe021145@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 12:49:04PM -0500, Paul Davis wrote:
> >RT-LSM introduces architectural problems in the form of bogus API. And
> 
> that may be true of LSM, but not RT-LSM in particular. RT-LSM doesn't
> introduce *any* API whatsoever - it simply allows software to call
> various existing APIs (mostly from POSIX) and have them not fail as
> result of not being root and/or not running on a capabilities-enabled
> kernel without the required caps.

The API is the parameters to modprobe or sysfs. 

> >it's implemented as an LSM is meaningless if Redhat and SuSE ship it
> >on by default.
> 
> We haven't encouraged anyone to ship anything with it on by default:
> the idea is for the module to be present and usable, not turned on.

On as in turned on for build in the kernel config and shipped. But I
expect people will eventually actually ship it _on_ with a group
called 'rt' and possibly even put the primary user in there on install
unless you start slapping some big fat warnings on it. (I just noticed
the new Debian installer is putting the primary user in audio, cdrom,
video, etc.)

-- 
Mathematics is the supreme nostalgia of our time.

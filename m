Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWEORXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWEORXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWEORXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:23:06 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:17280 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S965000AbWEORXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:23:05 -0400
Date: Mon, 15 May 2006 10:26:19 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: sej <sej@sej.fr>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Subject: Re: mlock into kernel module
Message-ID: <20060515172619.GT25010@moss.sous-sol.org>
References: <6bHKI-6a8-9@gated-at.bofh.it> <6bLbw-344-3@gated-at.bofh.it> <44683D61.7000405@sej.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44683D61.7000405@sej.fr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* sej (sej@sej.fr) wrote:
> So how to set rlimits ?

You have a few options.  Considering your program can't run as root,
that means directly using setrlimit (or smth like ulimit in bash) is
probably not right for you.  Take a look at the pam docs for
/etc/security/limits.conf, specifically for memlock.

> My program is in user mode and has to allocate about 128MB to 512MB of 
> non swappable memory. Maybe I can change the rlimits rights into my 
> kernel module ?

I have no idea what your kernel module is, nor what your exact
requirements are.  However, you shouldn't be changing rlimits in a
kernel module, there's plenty of userspace support for that.

thanks,
-chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVBXCeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVBXCeP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVBXCeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:34:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:16031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261757AbVBXCeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:34:02 -0500
Date: Wed, 23 Feb 2005 18:33:49 -0800
From: Chris Wright <chrisw@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] show RLIMIT_SIGPENDING usage in /proc/PID/status
Message-ID: <20050224023349.GF15867@shell0.pdx.osdl.net>
References: <421D0D3F.40902@goop.org> <200502240207.j1O272Yx010694@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502240207.j1O272Yx010694@magilla.sf.frob.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roland McGrath (roland@redhat.com) wrote:
> Jeremy mentioned the aggravation of not being able to tell when your
> processes are using up signal queue entries and hitting the
> RLIMIT_SIGPENDING limit.  This patch adds a line to /proc/PID/status
> showing how many queue items are in use, and allowed, for your uid.

Two questions:  1) This changes the interface for consumers of
/proc/[pid]/status data, do we care?  Adding new line like this should
be safe enough. 2) Perhaps we should do /proc/[pid]/rlimit/ type dir
for each value?  This has been asked for before.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

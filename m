Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVBXCz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVBXCz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVBXCz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:55:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56289 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261648AbVBXCzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:55:51 -0500
Date: Wed, 23 Feb 2005 18:55:45 -0800
Message-Id: <200502240255.j1O2tj8M010857@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Chris Wright <chrisw@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] show RLIMIT_SIGPENDING usage in /proc/PID/status
In-Reply-To: Chris Wright's message of  Wednesday, 23 February 2005 18:33:49 -0800 <20050224023349.GF15867@shell0.pdx.osdl.net>
X-Shopping-List: (1) Vitriolic winter sleeves
   (2) Seismic ambition invasions
   (3) Adamant cavernous remainder witches
   (4) Permanent food melons
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Two questions: 1) This changes the interface for consumers of
> /proc/[pid]/status data, do we care?  Adding new line like this should be
> safe enough.

As far as I can tell, noone fretted about the addition of Threads:,
ShdPnd:, etc., which were not always there.

> 2) Perhaps we should do /proc/[pid]/rlimit/ type dir for each value?
>    This has been asked for before.

Is the request to see the limit settings, or the current usage, or both?
What kind of format are you suggesting?  I don't see a need for something
with a million little files.  Also, for some of the limits the correct
current usage count is not trivial to ascertain.  (And for others like
RLIMIT_FSIZE and RLIMIT_CORE, it is of course not meaningful at all.)


Thanks,
Roland

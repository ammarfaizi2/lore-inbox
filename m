Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268351AbUHXV26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268351AbUHXV26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268344AbUHXV25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:28:57 -0400
Received: from waste.org ([209.173.204.2]:35235 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268353AbUHXV0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:26:44 -0400
Date: Tue, 24 Aug 2004 16:26:37 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] [4/4] /dev/random: Remove RNDGETPOOL ioctl
Message-ID: <20040824212637.GI5414@waste.org>
References: <E1By1St-0001TS-Qj@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1By1St-0001TS-Qj@thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 12:57:23AM -0400, Theodore Ts'o wrote:
> 
> Recently, someone has kvetched that RNDGETPOOL is a "security
> vulnerability".  Never mind that it is superuser only, and with
> superuser privs you could load a nasty kernel module, or read the
> entropy pool out of /dev/mem directly, but they are nevertheless still
> spreading FUD.

While such concerns are a bit exaggerated, the ioctl isn't in fact
very useful: it only gets one of the pools. In other words, it's been
obsolete even for debugging purposes since we went to two pools.

The pool resize ioctl is still racy in a painful way and ought to be
axed as well.

-- 
Mathematics is the supreme nostalgia of our time.

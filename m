Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTIKQO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbTIKQO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:14:57 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:28516 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261288AbTIKQOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:14:55 -0400
Date: Thu, 11 Sep 2003 09:14:50 -0700
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030911161450.GA23536@sgi.com>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	linux-kernel@vger.kernel.org
References: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 05:01:16PM +0100, Matthew Wilcox wrote:
> config MMIO
> 	bool "Prefer Memory-mapped I/O accesses over Port I/O"
> 	help
> 	  Many devices are accessible via both memory mapped I/O and
> 	  port I/O.  Say Y here to access them via the slightly faster
> 	  memory mapped I/O method.  If you experience problems, you may
> 	  wish to say N here.
> 
> If that's not acceptable, can I suggest that we at least ask a standard
> question?
> 
> config WWWW_MMIO
> 	bool "Use Memory mapped I/O in preference to Port I/O"
> 	depends on WWWW
> 	help
> 	  This device's registers can be accessed by either memory
> 	  mapped I/O or port I/O.  Memory mapped I/O is faster, so you
> 	  are advised to say Y here.
> 
> (yes, we could wordsmith these questions into the ground; the key point
> of this mail is whether we ask one question at the start of configuration
> or whether we ask one question per device.)

I like this idea, esp. as a global option.  It would help e.g. visws
which can't reliably do MMIO.  Most platforms could default MMIO to y
also, to make things easier.

Jesse

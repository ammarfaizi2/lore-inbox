Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUBNXiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 18:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUBNXiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 18:38:08 -0500
Received: from waste.org ([209.173.204.2]:47596 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263564AbUBNXiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 18:38:06 -0500
Date: Sat, 14 Feb 2004 17:37:58 -0600
From: Matt Mackall <mpm@selenic.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, tytso@thunk.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Updated dynamic pty patch available
Message-ID: <20040214233758.GD26247@waste.org>
References: <402B168E.4020000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402B168E.4020000@zytor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 10:00:46PM -0800, H. Peter Anvin wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/dynpty-test-2.patch
> 
> ... against the current top-of-bkcvs 2.6 kernel.
> 
> This version of the patch makes *both* legacy and Unix98 ptys configure 
> options (Unix98 only if EMBEDDED), and the number of legacy ptys is a 
> configuration option -- useful if you want to reduce the memory 
> footprint, or if you really wants lots of these guys (256 is no longer a 
> hard limit.)
> 
> Additionally, I have added a sysctl option -- /proc/sys/kernel/pty/max 
> -- for limiting the number of Unix98 ptys.  It was way too effective a 
> DoS to eat up all kernel memory by opening /dev/ptmx repeatedly.  The 
> default is 4096, but it can be adjusted all the way up to 2^20 if desirable.

Looks good, I'll drop this into -tiny when I have proper net access
again.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbVCJR0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVCJR0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVCJR0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:26:05 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39150 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262751AbVCJRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:21:29 -0500
Date: Thu, 10 Mar 2005 10:21:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gdavis@mvista.com
Subject: Re: 2.6.11-mm1
Message-ID: <20050310172122.GW3098@smtp.west.cox.net>
References: <20050304033215.1ffa8fec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304033215.1ffa8fec.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 03:32:15AM -0800, Andrew Morton wrote:

[snip]
> +fix-scripts-mkubootsh-to-return-status.patch
> 
>  kbuild fix

Please drop this.  The problem is that 'make uImage' was saying that it
sucessfully built a uImage when it didn't.  The reason we have a wrapper
script around mkimage (mkuboot.sh) is so that we can always provide a
uImage (it's cheap) if the user has the tools around (and thus probably
wants it), but can still have it in the 'all' target, and do no harm, in
the case where people don't.  This is currently upsetting a number of
ppc32 folks since uImage is a default target, but not really needed in
the common case (pmac).

-- 
Tom Rini
http://gate.crashing.org/~trini/

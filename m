Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWDFWPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWDFWPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 18:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWDFWPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 18:15:20 -0400
Received: from nevyn.them.org ([66.93.172.17]:7078 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751327AbWDFWPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 18:15:20 -0400
Date: Thu, 6 Apr 2006 18:15:19 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/binfmt_elf.c:maydump()
Message-ID: <20060406221519.GA5453@nevyn.them.org>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20060406.140357.14088592.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406.140357.14088592.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 02:03:57PM -0700, David S. Miller wrote:
> Yes, this means we might hit the core dump limits quicker but we
> shouldn't be doing anything which makes less debugging information
> than necessary available.  Software development is hard enough as
> it is right? :)

> -	/* If it hasn't been written to, don't write it out */
> -	if (!vma->anon_vma)
> -		return 0;
> -

Isn't this, um, a little more extreme than what you really want?
What goes into coredumps with this patch applied?  I bet it includes
the complete text segments of every executable and shared library
involved in the link.  You're going to need those if you want to debug,
anyway.

-- 
Daniel Jacobowitz
CodeSourcery

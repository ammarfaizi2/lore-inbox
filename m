Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWBZUAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWBZUAi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWBZUAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:00:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45832 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751352AbWBZUAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:00:38 -0500
Date: Sun, 26 Feb 2006 20:00:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-ID: <20060226200031.GC31256@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060226100518.GA31256@flint.arm.linux.org.uk> <20060226021414.6a3db942.akpm@osdl.org> <20060226181747.GB31256@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226181747.GB31256@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 06:17:47PM +0000, Russell King wrote:
> On Sun, Feb 26, 2006 at 02:14:14AM -0800, Andrew Morton wrote:
> > If we make it
> > 
> > 	if (!info) {
> > 		WARN_ON(1);
> > 		return;
> > 	}
> > 
> > will that allow people's kernels to limp along until it gets fixed?
> 
> "until" - I think you mean "if anyone ever bothers" so no I don't agree.
> The bluetooth folk seem to have absolutely no interest in bug fixing.
> Can we mark bluetooth broken please?

Sorry, I mean just mark BT_HCIUART broken, not the whole of bluetooth.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

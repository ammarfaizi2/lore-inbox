Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbTILXEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTILXEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:04:53 -0400
Received: from holomorphy.com ([66.224.33.161]:36030 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261813AbTILXEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:04:52 -0400
Date: Fri, 12 Sep 2003 16:06:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Breno <brenosp@brasilsec.com.br>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: stack overflow
Message-ID: <20030912230601.GU4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Breno <brenosp@brasilsec.com.br>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <002b01c37956$d88d67c0$f8e4a7c8@bsb.virtua.com.br> <20030912165047.Z18851@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912165047.Z18851@schatzie.adilger.int>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 04:50:47PM -0600, Andreas Dilger wrote:
> Well, with the exception of the fact that STACK_LIMIT is 8MB, and kernel
> stacks are only 8kB (on i386)...
> Also, see "do_IRQ()" (i386) for CONFIG_DEBUG_STACKOVERFLOW to see this already.

What he actually wants is in-kernel user stack overflow checking, which
is basically impossible since user stacks are demand paged. He's been
told this before and failed to absorb it.

There have been attempts to use i386 segmentation for stack limit
checks written but they should probably not be confused with this.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWAIScN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWAIScN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWAIScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:32:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13842 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030249AbWAIScL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:32:11 -0500
Date: Mon, 9 Jan 2006 18:32:04 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-git: BITS_PER_LONG
Message-ID: <20060109183204.GB19131@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Lameter <clameter@engr.sgi.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20060107144940.GE31384@flint.arm.linux.org.uk> <Pine.LNX.4.62.0601090956340.2202@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601090956340.2202@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 09:57:29AM -0800, Christoph Lameter wrote:
> On Sat, 7 Jan 2006, Russell King wrote:
> > With the latest git, I'm seeing a number of:
> > 
> > include/asm-generic/atomic.h:20:5: warning: "BITS_PER_LONG" is not defined
> > 
> > What's intended here?  Should asm-generic/atomic.h include asm/types.h?
> 
> asm/types.h should be included by asm/atomic.h.

Disagree - nothing in asm/atomic.h needs asm/types.h.  If
asm-generic/atomic.h has this requirement, it should be the one
including asm/types.h (or should it be linux/types.h ?)

> Which arch is this?

ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

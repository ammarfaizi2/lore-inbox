Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVCJWz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVCJWz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbVCJWww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:52:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55560 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262086AbVCJWwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:52:01 -0500
Date: Thu, 10 Mar 2005 22:51:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steven Cole <elenstev@mesatop.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: Someting's busted with serial in 2.6.11 latest
Message-ID: <20050310225151.E1044@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Cole <elenstev@mesatop.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net> <20050310195326.A1044@flint.arm.linux.org.uk> <4230CCCB.6030909@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4230CCCB.6030909@mesatop.com>; from elenstev@mesatop.com on Thu, Mar 10, 2005 at 03:40:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 03:40:11PM -0700, Steven Cole wrote:
> Russell King wrote:
> > On Wed, Mar 09, 2005 at 03:50:49PM -0800, Stephen Hemminger wrote:
> > 
> >>Some checkin since 2.6.11 has caused the serial driver to
> >>drop characters.  Console output is chopped and messages are garbled.
> >>Even the shell prompt gets truncated.
> > 
> > 
> > There was a problem with 2.6.11-bk1 which should now be resolved.
> > 
> > Is this still true of the latest bk kernel?  Also, seeing the kernel
> > messages may provide some hint.
> > 
> 
> Here is a post I made perhaps relevant to this.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111042402103071&w=2
> 
> I'll test current bk tonight, but I don't see any recent fix to
> drivers/serial/8250.c when browsing linux.bkbits.net/linux-2.6.

There are only two recent revisions to 8250.c.  One adds slightly buggy
Xscale UART detection, the other fixes the buggyness.

What I don't know is whether either of these two changes are the cause
of your exact problems, because I don't actually know what you're
testing.  Since Stephen's bug is a lot more well defined than yours,
it makes sense to tackle Stephen's situation first.

The reason for this is taht pppd getting a SIGHUP doesn't actually tell
me anything at all.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbTDNDYR (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 23:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTDNDYR (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 23:24:17 -0400
Received: from crack.them.org ([65.125.64.184]:1182 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S262722AbTDNDYQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 23:24:16 -0400
Date: Sun, 13 Apr 2003 23:35:48 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: John Reiser <jreiser@BitWagon.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: observe & control thread state for exit futex ?
Message-ID: <20030414033548.GA4048@nevyn.them.org>
Mail-Followup-To: John Reiser <jreiser@BitWagon.com>,
	linux-kernel@vger.kernel.org
References: <3E9A2258.9020507@BitWagon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9A2258.9020507@BitWagon.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 07:52:08PM -0700, John Reiser wrote:
> How can a debugger, newly attached to an arbitrary thread, determine whether
> the thread has a pending exit futex and associated memory location to clear
> [CLONE_CHILD_CLEARTID flag and child_tid_ptr parameter at __clone()]?
> 
> If so, then how can the debugger determine the address, change the address,
> cancel the futex, and/or intercept the notification?

It can't.  Even clone flags are not accessible.

If you can think of a good reason that a debugger would need any
particular piece of data, exposing it is very straightforward.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

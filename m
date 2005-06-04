Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVFDIQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVFDIQB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 04:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVFDIQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 04:16:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29968 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261293AbVFDIPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 04:15:55 -0400
Date: Sat, 4 Jun 2005 09:15:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
Message-ID: <20050604091544.A30959@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050603163843.1cf5045d.akpm@osdl.org>; from akpm@osdl.org on Fri, Jun 03, 2005 at 04:38:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 04:38:43PM -0700, Andrew Morton wrote:
> Subject: Bug in 8520.c - port.type not set for serial console

I think this is another case of someone reporting a problem and not
providing any feedback to replies.  Bjorn followed up on this and
I haven't seen a response.

However, port.type won't be set for serial console.  This is entirely
expected.  We haven't approached the normal port initialisation and
as such we treat the port as being the lowest common denominator - a
standard 8250 port.

If we do want port.type initialised, the solution for this is to get
rid of the early initialisation of 8250-based consoles entirely, which
is something I keep saying and not doing because I know I'm going to
get whinged at.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

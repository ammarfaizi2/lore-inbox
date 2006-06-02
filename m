Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWFBPS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWFBPS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 11:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWFBPS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 11:18:58 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:41634 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932171AbWFBPS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 11:18:57 -0400
Date: Fri, 2 Jun 2006 11:19:16 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, "Christopher S. Aker" <caker@theshore.net>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: non-scalar ktime addition and subtraction broken
Message-ID: <20060602151916.GC4708@ccure.user-mode-linux.org>
References: <20060602030825.GA8006@ccure.user-mode-linux.org> <1149231262.20582.119.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149231262.20582.119.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 08:54:22AM +0200, Thomas Gleixner wrote:
> NAK. ktime_t is defined that ist must be normalized the same way as
> timespecs. The nsec part must be >= 0 and < NSEC_PER_SEC. Fix the part
> which is feeding non normalized values.

Aha, that would be me, initializing wall_to_monotonic incorrectly.  Thanks
for the clue.

				Jeff

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270407AbTGSRpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 13:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270421AbTGSRpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 13:45:12 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:28171 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270407AbTGSRo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 13:44:59 -0400
Date: Sat, 19 Jul 2003 18:59:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] fix include/linux/sysctl.h for userland
Message-ID: <20030719185954.A11061@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bernardo Innocenti <bernie@develer.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <200307191952.35499.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307191952.35499.bernie@develer.com>; from bernie@develer.com on Sat, Jul 19, 2003 at 07:52:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 07:52:35PM +0200, Bernardo Innocenti wrote:
> 
> Include linux/compiler.h in include/linux/sysctl.h. Needed to get __user
> defined when C library uses this header (ie: no __KERNEL__).

It shouldn't be included from userspace, and glibc needs to be fixed not
to do so.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUFMJFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUFMJFa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 05:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbUFMJFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 05:05:30 -0400
Received: from calvin.stupendous.org ([213.84.70.4]:50692 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S265029AbUFMJFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 05:05:25 -0400
Date: Sun, 13 Jun 2004 11:05:43 +0200
From: Jurjen Oskam <jurjen@stupendous.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.6.6 tty_io.c hangup locking
Message-ID: <20040613090543.GA29699@quadpro.stupendous.org>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	linux-kernel@vger.kernel.org
References: <20040527174509.GA1654@quadpro.stupendous.org> <1085769769.2106.23.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085769769.2106.23.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 01:42:50PM -0500, Paul Fulghum wrote:

> The following patch removes unnecessary disabling of
> interrupts when processing hangup for tty devices.
> 
> This was introduced way back in August 1998
> with patch 2.1.115 when the original hangup processing was
> changed from cli/sti to lock_kernel()/unlock_kernel().

I applied this patch to vanilla 2.2.5, and have been running with it
for a week or two. During that time, I frequently used PPP. For testing, I
interrupted the connection when sending and/or receiving data.

I didn't experience any problems whatsoever. 

Thanks,
-- 
Jurjen Oskam

"Avoid putting a paging file on a fault-tolerant drive, such as a mirrored
volume or a RAID-5 volume. Paging files do not need fault-tolerance."-MS Q308417

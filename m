Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbUJYJjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbUJYJjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUJYJjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:39:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47630 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261732AbUJYJja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:39:30 -0400
Date: Mon, 25 Oct 2004 10:39:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andreas Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/17] Generic backward compatibility includes for 4level
Message-ID: <20041025103926.A31632@flint.arm.linux.org.uk>
Mail-Followup-To: Andreas Kleen <ak@suse.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <417CAA05.mail3Y411778M@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <417CAA05.mail3Y411778M@wotan.suse.de>; from ak@suse.de on Mon, Oct 25, 2004 at 09:23:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 09:23:49AM +0200, Andreas Kleen wrote:
> +/* Included by architectures that don't have a fourth page table level.
> +
> +   pml4 is simply casted to pgd */
> +
> +#define pml4_ERROR(x) 

Don't we normally add do { } while (0) after empty macros which look like
a function?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

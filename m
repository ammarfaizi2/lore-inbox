Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVCYHi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVCYHi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVCYHi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:38:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46864 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261510AbVCYHiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:38:50 -0500
Date: Fri, 25 Mar 2005 07:38:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Miles Lane <miles.lane@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
Message-ID: <20050325073846.A18596@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Miles Lane <miles.lane@gmail.com>, linux-kernel@vger.kernel.org
References: <20050324044114.5aa5b166.akpm@osdl.org> <a44ae5cd05032420122cd610bd@mail.gmail.com> <20050324202215.663bd8a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050324202215.663bd8a9.akpm@osdl.org>; from akpm@osdl.org on Thu, Mar 24, 2005 at 08:22:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 08:22:15PM -0800, Andrew Morton wrote:
> Miles Lane <miles.lane@gmail.com> wrote:
> >  Unable to handle kernel paging request at virtual address 24fc1024
> >  c0198448
> >  *pde = 00000000
> >  Oops: 0000 [#1]
> >  CPU:    0
> >  EIP:    0060:[<c0198448>]    Not tainted VLI
> 
> I wonder why the EIP sometimes doesn't get decoded.
> 
> >  Using defaults from ksymoops -t elf32-i386 -a i386
> >  EFLAGS: 00210206   (2.6.12-rc1-mm2)

ksymoops seems to remove lines from the kernel output that it doesn't
like.  I've seen this many times on ARM, and each time I see an oops
from a 2.6 kernel which has been ksymoopsed, I always ask the submitter
to send the original non-ksymoopsed version.

Users need to be re-educated _not_ to use ksymoops.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

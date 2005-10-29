Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbVJ2Iyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVJ2Iyx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 04:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVJ2Iyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 04:54:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9737 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750796AbVJ2Iyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 04:54:52 -0400
Date: Sat, 29 Oct 2005 09:54:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MACHINE_START fix
Message-ID: <20051029085447.GB32513@flint.arm.linux.org.uk>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20051029054301.GZ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029054301.GZ7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 06:43:01AM +0100, Al Viro wrote:
> 	unreferenced static variables can be killed by cc(1), so when
> we want them to survive (we collect these suckers in array in special
> section), we'd better not make them static.

Except this causes sparse to complain, which is why I made it static
last night.  Patch nacked.

What I did miss was making it __attribute_used__ which would be the
correct answer.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

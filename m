Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVCTNwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVCTNwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 08:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVCTNwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 08:52:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5385 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261211AbVCTNwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 08:52:12 -0500
Date: Sun, 20 Mar 2005 13:52:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: af_unix.c, KBUILD_MODNAME and unix
Message-ID: <20050320135207.A12839@flint.arm.linux.org.uk>
Mail-Followup-To: Magnus Damm <magnus.damm@gmail.com>,
	linux-kernel@vger.kernel.org
References: <aec7e5c305032005451899b18b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <aec7e5c305032005451899b18b@mail.gmail.com>; from magnus.damm@gmail.com on Sun, Mar 20, 2005 at 02:45:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2005 at 02:45:36PM +0100, Magnus Damm wrote:
> Hello All,
> 
> af_unix.c is currenty built with KBUILD_MODNAME=unix. This seems to
> work rather well today, but if someone actually tries to use
> KBUILD_MODNAME then they will end up with a preprocessor surprise:
> KBUILD_MODNAME -> unix -> 1, because "unix" is defined to 1.
> 
> With other words, if someone adds module_param(foo,...) code to
> af_unix.c and compiles the code as built in then they will have to use
> "1.foo" to set the variable instead of "unix.foo" as expected.
> 
> Solution? #undef unix?

or maybe -Uunix ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

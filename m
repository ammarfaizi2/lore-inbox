Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbUDFKKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 06:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbUDFKKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 06:10:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13072 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263746AbUDFKKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 06:10:19 -0400
Date: Tue, 6 Apr 2004 11:10:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: {put,get}_user() side effects
Message-ID: <20040406111013.B15945@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.58.0404061159330.4158@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.58.0404061159330.4158@waterleaf.sonytel.be>; from geert@linux-m68k.org on Tue, Apr 06, 2004 at 12:03:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 12:03:14PM +0200, Geert Uytterhoeven wrote:
> On most (all?) architectures {get,put}_user() has side effects:
> 
> #define put_user(x,ptr)                                                 \
>   __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))

I thought this came up before, and it was decided that put_user and
get_user must not have such side effects - I certainly remember fixing
this very thing on ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

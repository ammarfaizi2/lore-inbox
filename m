Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSGVAhO>; Sun, 21 Jul 2002 20:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSGVAhO>; Sun, 21 Jul 2002 20:37:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52236 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315372AbSGVAhN>; Sun, 21 Jul 2002 20:37:13 -0400
Date: Mon, 22 Jul 2002 01:40:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
Message-ID: <20020722014018.A31813@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207211619480.9993-100000@home.transmeta.com> <Pine.LNX.4.44.0207220224170.4909-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207220224170.4909-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Jul 22, 2002 at 02:31:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 02:31:16AM +0200, Ingo Molnar wrote:
> +drivers that want to disable local interrupts (interrupts on the
> +current CPU), can use the following four macros:
> +
> +  __cli(), __sti(), __save_flags(flags), __restore_flags(flags)

Last mail before zzz (hopefully) - what about
local_irq_{enable,disable,save,restore} ?

With the exception of local_irq_save() which is actually
local_irq_save_disable(), I find these to be more "descriptive" of
their function.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


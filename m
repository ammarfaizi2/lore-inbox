Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbTIJIu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbTIJIu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:50:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37137 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264786AbTIJIu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:50:28 -0400
Date: Wed, 10 Sep 2003 09:50:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Anton Blanchard <anton@samba.org>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rjwalsh@durables.org
Subject: Re: [PATCH 1/3] netpoll api
Message-ID: <20030910095015.A17058@flint.arm.linux.org.uk>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, rjwalsh@durables.org
References: <20030910074030.GC4489@waste.org> <20030910004907.67b90bd1.akpm@osdl.org> <20030910081845.GF4489@waste.org> <20030910083935.GG1532@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910083935.GG1532@krispykreme>; from anton@samba.org on Wed, Sep 10, 2003 at 06:39:35PM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 06:39:35PM +1000, Anton Blanchard wrote:
> > Hmmm, linux/irq.h seemed pretty generic. Maybe those other, silly
> > arches can mend their ways?

No chance.  linux/irq.h describes one implementation which is suitable
for some archtectures.  However, there are cases where it just doesn't
fit the requirements, and architectures are then free to implement
whatever they want.

linux/irq.h is a badly placed header file - it should have been placed
in asm-generic.  It was never intended to be included by .c files, only
by asm-*/irq.h.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core

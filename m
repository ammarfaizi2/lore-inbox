Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUA1I6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 03:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUA1I6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 03:58:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2317 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265875AbUA1I6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 03:58:33 -0500
Date: Wed, 28 Jan 2004 08:58:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
Message-ID: <20040128085825.A3591@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ia64 <linux-ia64@vger.kernel.org>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com> <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>; from torvalds@osdl.org on Tue, Jan 27, 2004 at 06:55:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 06:55:17PM -0800, Linus Torvalds wrote:
> Does anybody see any downsides to something like this?

What if the failing PCI access happened in an interrupt routine?
(I'm thinking of the situation where you may need to read the PCI
status registers to find out whether an error occurred.)

Also, for that matter, what if a network device receives an abort
while performing BM-DMA?

Do we even care about either of these two scenarios?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

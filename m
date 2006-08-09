Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWHICKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWHICKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWHICKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:10:06 -0400
Received: from [198.99.130.12] ([198.99.130.12]:46292 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751238AbWHICKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:10:05 -0400
Date: Tue, 8 Aug 2006 22:09:35 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andi Kleen <ak@suse.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Rob Landley <rob@landley.net>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [uml-devel] [PATCH 1/2] Split i386 and x86_64 ptrace.h
Message-ID: <20060809020935.GB8201@ccure.user-mode-linux.org>
References: <200608082058.k78KwGa4006531@ccure.user-mode-linux.org> <p73u04mol9k.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73u04mol9k.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 01:33:43AM +0200, Andi Kleen wrote:
> I think I would prefer a well placed ifdef __KERNEL__ or two for this - i don't
> like it when it becomes harder to grep include files like this
> (like the errno->errno-base split was quite bad in this regard)

__KERNEL__ doesn't help because UML defines it just like any other arch.

If you want to play ifdef tricks, it would have to be #ifdef UML, or something
similar.

				Jeff

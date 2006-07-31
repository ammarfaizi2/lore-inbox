Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWGaXuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWGaXuy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWGaXux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:50:53 -0400
Received: from mail.suse.de ([195.135.220.2]:42730 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750760AbWGaXuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:50:52 -0400
From: Andi Kleen <ak@suse.de>
To: Diego Calleja <diegocg@gmail.com>
Subject: Re: [PATCH] AUX_DEVICE_INFO is one byte long, use 'movb'
Date: Tue, 1 Aug 2006 01:50:40 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060801014727.603e25a4.diegocg@gmail.com>
In-Reply-To: <20060801014727.603e25a4.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608010150.40529.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 01:47, Diego Calleja wrote:
> Bugzilla #6552 says:
> 
> "In arch/i386/boot/setup.S, movw is used instead of movb for PS/2 mouse
> information, although it is unsigned char. This does not harm, because
> the jmp instruction overwritten by movw is used before executing movw,
> and never be used again"
> 
> I've no idea if this is a real bug or how it gets fixed, so I'm submitting
> it for review instead of letting it die of boredom in bugzilla. Aditionally
> to i386, I've changed x86-64, which mirrors the same code.
> 
> Credits to Yoshinori K. Okuji, who found the problem and suggested a fix.

Queued thanks.

-Andi

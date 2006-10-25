Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWJYPnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWJYPnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 11:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbWJYPnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 11:43:17 -0400
Received: from [198.99.130.12] ([198.99.130.12]:53145 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751495AbWJYPnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 11:43:16 -0400
Date: Wed, 25 Oct 2006 11:41:30 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Mitch <Mitch@0Bits.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1
Message-ID: <20061025154130.GF4323@ccure.user-mode-linux.org>
References: <453E7F07.9010804@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453E7F07.9010804@0Bits.COM>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 01:00:55AM +0400, Mitch wrote:
> I've definetly not done any such change on my machine. Remember with the 
> same compile, same environment, if i go back to 2.6.18 i can build uml 
> fine. If i move to 2.6.18.1 or above it breaks...

You're sure about that?  I just looked through the 2.6.18.1 changelog and
I see nothing that would cause this.

> I do notice my gcc stddef does have this defined
> 
> % grep offsetof /usr/lib/gcc/i686-linux/4.0.3/include/stddef.h
> #define offsetof(TYPE, MEMBER) __builtin_offsetof (TYPE, MEMBER)

I would do a -E build and make sure that this header, or another one that
defines offsetof is getting pulled in.

				Jeff

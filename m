Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275463AbTHJCHi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 22:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275465AbTHJCHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 22:07:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37615 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S275463AbTHJCHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 22:07:37 -0400
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
From: Robert Love <rml@tech9.net>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       jmorris@intercode.com.au, davem@redhat.com
In-Reply-To: <20030809143314.GT31810@waste.org>
References: <20030809074459.GQ31810@waste.org>
	 <20030809143314.GT31810@waste.org>
Content-Type: text/plain
Message-Id: <1060481247.31499.62.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sat, 09 Aug 2003 19:07:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-09 at 07:33, Matt Mackall wrote:

> - the random number generator is non-optional because it's used
>   various things from filesystems to networking

What if you kept crypto API optional, made random.c a config option, and
make that depend on the crypto API. Then -- and this is the non-obvious
part -- implement a super lame replacement for get_random_bytes() [what
I assume the various parts of the kernel are using] for when
!CONFIG_RANDOM is not set?

You can do a simple PRNG in <10 lines of C. Have the kernel seed it on
boot with xtime or something else lame.

	Robert Love



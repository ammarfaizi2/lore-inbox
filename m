Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUA3RcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUA3RcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:32:15 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:8879 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S262745AbUA3RcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:32:12 -0500
Date: Fri, 30 Jan 2004 12:26:36 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Dave Paris <dparis@w3works.com>, linux-kernel@vger.kernel.org,
       rspchan@starhub.net.sg
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
Message-ID: <20040130172636.GA7382@certainkey.com>
References: <Xine.LNX.4.44.0401300939070.15830-100000@thoron.boston.redhat.com> <PLEIIGNDLGEDDKABPLHBAECPCHAA.dparis@w3works.com> <20040130152835.GN31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130152835.GN31589@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub said something like...
> GCC handling of automatic const variables with initializers is very fragile.
> There have been numerous bugs in it in the past and last one has been fixed
> just yesterday (on GCC trunk only for the time being).  It will be
> eventually backported once it gets some more testing on GCC mainline.
> 
> The problematic line in sha256.c is:
> static void sha256_final(void* ctx, u8 *out)
> {
> ...
> 	const u8 padding[64] = { 0x80, };

Verry interesting.  Good work Jakub.

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6

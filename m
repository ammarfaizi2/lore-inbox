Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272137AbTHIAVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272140AbTHIAVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:21:35 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:11140 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272137AbTHIAVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:21:34 -0400
Date: Sat, 9 Aug 2003 01:21:17 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, chip@pobox.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030809002117.GB26375@mail.jlokier.co.uk>
References: <1060087479.796.50.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060087479.796.50.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> // tell gcc what to expect:   if(unlikely(err)) die(err);
> #define likely(x)       __builtin_expect(!!(x),1)
> #define unlikely(x)     __builtin_expect(!!(x),0)
> #define expected(x,y)   __builtin_expect((x),(y))

You may want to check that GCC generates the same code as for

	#define likely(x)	__builtin_expect((x),1)
	#define unlikely(x)	__builtin_expect((x),0)

I tried this once, and I don't recall the precise result but I do
recall it generating different code (i.e. not optimal for one of the
definitions).

-- Jamie

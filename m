Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUFKEhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUFKEhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 00:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbUFKEhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 00:37:24 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:42444 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263761AbUFKEhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 00:37:23 -0400
Date: Thu, 10 Jun 2004 21:36:59 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
Message-Id: <20040610213659.0fd93039.pj@sgi.com>
In-Reply-To: <20040609015001.31d249ca.akpm@osdl.org>
References: <20040609015001.31d249ca.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Do you recall why your i386-uninline-bitops.patch moves i386
find_next_bit() and find_next_zero_bit() out of line, but not
find_first_zero_bit() nor find_first_bit()?

Text sizes - i386 optimized routine (decimal):
    find_next_zero_bit	132
    find_next_bit 	114
    find_first_zero_bit  76
    find_first_bit	 50

Uninlining find_first_bit() reduces my i386 kernel text size by 1336 bytes.

Uninlining find_first_zero_bit() is good for another 208 bytes.

Eh - perhaps this is too small potatoes to worry about now.

Or perhaps there was good reason to leave them inline all along.

Perhaps someone else has further insight to the tradeoffs here, such as
a 'recommended size', above which most routines should be not inlined,
except in special cases.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUIWQ5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUIWQ5R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUIWQ5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:57:17 -0400
Received: from holomorphy.com ([207.189.100.168]:62935 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268183AbUIWQue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:50:34 -0400
Date: Thu, 23 Sep 2004 09:50:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, rth@twiddle.net
Subject: Re: __attribute__((always_inline)) fiasco
Message-ID: <20040923165026.GF9106@holomorphy.com>
References: <1095956778.4966.940.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095956778.4966.940.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 12:26:18PM -0400, Albert Cahalan wrote:
> #define INLINE
> #define INLINE inline
> #define INLINE static inline  // an oxymoron
> #define INLINE extern inline  // an oxymoron
> #define INLINE __force_inline
> #define INLINE __attribute__((always_inline))
> #define INLINE _Pragma("inline")
> #define INLINE __inline_or_die_you_foul_compiler
> #define INLINE _Please inline

The // apart from being a C++ ism (screw C99; it's still non-idiomatic)
will cause spurious ignorance of the remainder of the line, which is
often very important. e.g.

static INLINE int lock_need_resched(spinlock_t *lock)
{
	...


-- wli

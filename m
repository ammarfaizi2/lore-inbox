Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268165AbUIWRKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268165AbUIWRKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUIWRIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:08:54 -0400
Received: from are.twiddle.net ([64.81.246.98]:14467 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S268186AbUIWRDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:03:48 -0400
Date: Thu, 23 Sep 2004 10:03:44 -0700
From: Richard Henderson <rth@twiddle.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: __attribute__((always_inline)) fiasco
Message-ID: <20040923170344.GD11968@twiddle.net>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1095956778.4966.940.camel@cube> <20040923165026.GF9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923165026.GF9106@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 09:50:26AM -0700, William Lee Irwin III wrote:
> > #define INLINE static inline  // an oxymoron
...
> The // apart from being a C++ ism (screw C99; it's still non-idiomatic)
> will cause spurious ignorance of the remainder of the line, which is
> often very important. e.g.
> 
> static INLINE int lock_need_resched(spinlock_t *lock)

No it won't.  Comments are removed in translation phase 3;
macros are expanded in translation phase 4.


r~

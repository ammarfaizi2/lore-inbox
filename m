Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUHGCl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUHGCl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 22:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268226AbUHGCl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 22:41:58 -0400
Received: from are.twiddle.net ([64.81.246.98]:55425 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S266183AbUHGCl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 22:41:57 -0400
Date: Fri, 6 Aug 2004 19:41:53 -0700
From: Richard Henderson <rth@twiddle.net>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is extern inline -> static inline OK?
Message-ID: <20040807024153.GB25900@twiddle.net>
Mail-Followup-To: Tim Bird <tim.bird@am.sony.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <4112D32B.4060900@am.sony.com> <20040806070027.GA20642@twiddle.net> <4113D480.9050003@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4113D480.9050003@am.sony.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 11:57:04AM -0700, Tim Bird wrote:
>  2) avoid wasting space with multiple function copies

Mostly this one.  The translation units that do the EXTERN_INLINE
defines also define tables containing (among other things) pointers
to all of these functions.  So we *know* that we require one out-of-line
copy in one translation unit, so we might as well make that version the
canonical out-of-line copy.

Also, I seem to recall some multiply-defined symbol something or
other the last time someone messed with our inlining construct.


r~

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312772AbSDFUMo>; Sat, 6 Apr 2002 15:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312773AbSDFUMn>; Sat, 6 Apr 2002 15:12:43 -0500
Received: from zero.tech9.net ([209.61.188.187]:24582 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312772AbSDFUMm>;
	Sat, 6 Apr 2002 15:12:42 -0500
Subject: Re: [PATCH] Clean up x86 interrupt entry code
From: Robert Love <rml@tech9.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CAF54AA.1020303@didntduck.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 Apr 2002 15:11:54 -0500
Message-Id: <1018123940.899.104.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-06 at 15:03, Brian Gerst wrote:

> -ENTRY(ret_from_intr)
> -	GET_THREAD_INFO(%ebx)
> -	init_ret_intr
> +ret_from_intr:
> +	preempt_stop
> +	DEC_PRE_COUNT(%ebx)

You removed GET_THREAD_INFO and there does not seem to be a
replacement.  Is there some assurance *thread_info is now pointed to by
%ebx here?

	Robert Love


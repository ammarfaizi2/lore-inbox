Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbSLQTFK>; Tue, 17 Dec 2002 14:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbSLQTFK>; Tue, 17 Dec 2002 14:05:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61700 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266939AbSLQTFJ>; Tue, 17 Dec 2002 14:05:09 -0500
Message-ID: <3DFF772E.2050107@transmeta.com>
Date: Tue, 17 Dec 2002 11:12:46 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> It's not as good as a pure user-mode solution using tsc could be, but
> we've seen the kinds of complexities that has with multi-CPU systems, and
> they are so painful that I suspect the sysenter approach is a lot more
> palatable even if it doesn't allow for the absolute best theoretical
> numbers.
> 

The complexity only applies to nonsynchronized TSCs though, I would
assume.  I believe x86-64 uses a vsyscall using the TSC when it can
provide synchronized TSCs, and if it can't it puts a normal system call
inside the vsyscall in question.

	-hpa



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287048AbSBKFEl>; Mon, 11 Feb 2002 00:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287193AbSBKFEc>; Mon, 11 Feb 2002 00:04:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7434 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287048AbSBKFER>;
	Mon, 11 Feb 2002 00:04:17 -0500
Message-ID: <3C6750CD.46575DAA@mandrakesoft.com>
Date: Mon, 11 Feb 2002 00:04:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Weber <weber@nyc.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 Compile Error
In-Reply-To: <3C674CFA.2030107@nyc.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber wrote:
> /usr/src/linux-2.5.4/include/asm/processor.h: In function `thread_saved_pc':
> /usr/src/linux-2.5.4/include/asm/processor.h:444: dereferencing pointer
> to incomplete type
> make: *** [init/main.o] Error 1

since it's just for /usr/bin/ps, ie. not a fast path, I just un-inlined
it in my alpha hacking.  Same approach might work for here, too.

The basic problem, I'm guessing, is that asm/processor.h wants to know
about the internals of task struct, but it can't yet.

	Jeff




-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280275AbRKFTQs>; Tue, 6 Nov 2001 14:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280273AbRKFTQi>; Tue, 6 Nov 2001 14:16:38 -0500
Received: from ns.suse.de ([213.95.15.193]:529 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280246AbRKFTQc>;
	Tue, 6 Nov 2001 14:16:32 -0500
Date: Tue, 6 Nov 2001 20:16:31 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <20011106134234.A27718@redhat.com>
Message-ID: <Pine.LNX.4.30.0111062012580.5432-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Benjamin LaHaise wrote:

> Here are some numbers:
> Which come from insmod of the below two modules.  I didn't test writing to
> the stack register, but I expect it's similarly expensive as it affects the
> call return stack and other behind the scenes dependancies.  Suffice it to
> say that reading %cr2 is essentially free on my box (athlon mp).  Maybe
> we should use it as a pointer into a per-cpu area to avoid writing it?

If this is done, it should perhaps be done on only on certain x86s,
as some show the results go the other way. For example, the Cyrix III..

read stk best: 42  av: 42.60
read cr2 best: 61  av: 61.28

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


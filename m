Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287348AbSBKGuS>; Mon, 11 Feb 2002 01:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287344AbSBKGuJ>; Mon, 11 Feb 2002 01:50:09 -0500
Received: from zero.tech9.net ([209.61.188.187]:11022 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287303AbSBKGty>;
	Mon, 11 Feb 2002 01:49:54 -0500
Subject: Re: 2.5.4 Compile Error
From: Robert Love <rml@tech9.net>
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C67666B.2060507@nyc.rr.com>
In-Reply-To: <3C674CFA.2030107@nyc.rr.com>	<3C6750CD.46575DAA@mandrakesoft.com> 
	<3C675E6B.4010605@nyc.rr.com> <1013408447.806.409.camel@phantasy> 
	<3C67666B.2060507@nyc.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 01:50:01 -0500
Message-Id: <1013410201.6785.413.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-11 at 01:36, John Weber wrote:

> I understand all this, but thread is not a pointer.
> So shouldn't it be t->thread.esp ?

You are right, I missed this.

The fix is to change it to `((unsigned long *)tsk->thread.esp)[3]' but
we also still have to fix the dependency problem, which means moving it
out of processor.h.  Andrew Morton just posted a patch to move it to
process.c, I think he has it right.  Give that a try.

> *(p + (3*sizeof(p))) ?

Right ;)

	Robert Love


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312843AbSDFVpT>; Sat, 6 Apr 2002 16:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312846AbSDFVpS>; Sat, 6 Apr 2002 16:45:18 -0500
Received: from zero.tech9.net ([209.61.188.187]:43270 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312843AbSDFVpS>;
	Sat, 6 Apr 2002 16:45:18 -0500
Subject: Re: [PATCH] Clean up x86 interrupt entry code
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Brian Gerst <bgerst@didntduck.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204061216570.26740-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 Apr 2002 16:45:20 -0500
Message-Id: <1018129520.899.113.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-06 at 15:18, Linus Torvalds wrote:

> It seems to be always loaded by the common interrupt code (and %ebx is a 
> call-saved register, so calling the interrupt handlers and returning 
> doesn't clobber it).

True enough.  I guess I should of done this from the beginning ...

> But testing it may be a good idea ;^p

Of course I will, but it is hard (and subject to Heisenberg principals)
to test that we preempt whenever necessary.  Only with the patch I sent
you earlier am I seeing no missed preemptions ... now to work on the
egregiously long-held locks.

	Robert Love


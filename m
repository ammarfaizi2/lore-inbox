Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKYCh7>; Fri, 24 Nov 2000 21:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129492AbQKYCht>; Fri, 24 Nov 2000 21:37:49 -0500
Received: from smtp2.Mountain.Net ([198.77.1.5]:55518 "EHLO
        nabiki.mountain.net") by vger.kernel.org with ESMTP
        id <S129153AbQKYChl>; Fri, 24 Nov 2000 21:37:41 -0500
Message-ID: <3A1F1CD0.E2FCCE27@mountain.net>
Date: Fri, 24 Nov 2000 20:58:40 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Ishikawa <ishikawa@yk.rim.or.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test-11: K7 compile error: `current' missing in string macro.
In-Reply-To: <3A1F0DF0.AECF7057@yk.rim.or.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ishikawa wrote:
> 
> 2.4.0-test-11: K7 compile error: `current' missing in string macro.
> 
> Symptom:
> 2.4.0-test11 won't compile with K7 if we choose it for CPU.
> 
> The compile error is attached at the end.
> 
> The same config except for CPU (AMD K6) works.
> The diff of config is shown immediately below.
> (I saved the old config from some early test-1x series
> compilation.)
> 
[...]
> 
> HALF-HEARTED FIX suggestion.:
> 
> I looked around and found asm/current.h had this
> #define current get_current()
> 
> 
> QUESTION: Shouldn't this code  be enabled for AMD K6-III
> (not K7), too? (It would boost the performance on this CPU if so.)
> Or does K6-III lack some instructions of 3D-Now (available
> in K7, Athlon or Duron) and so can't use these macros?
> 
> Either way, asm/current.h needs to be included
> somewhere (probably after the include statements quoted above?)

Either deselect SMP or see the patch I posted here in May. If you just keep
adding headers for stuff in_interrupt() needs, you soon hit a circular
dependency.

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

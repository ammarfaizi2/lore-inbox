Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282820AbRK0Gb3>; Tue, 27 Nov 2001 01:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282821AbRK0GbW>; Tue, 27 Nov 2001 01:31:22 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:33570 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S282820AbRK0GbA>; Tue, 27 Nov 2001 01:31:00 -0500
Message-Id: <5.0.2.1.2.20011127011901.009ebd30@pop.mindspring.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 27 Nov 2001 01:32:19 -0500
To: Robert Love <rml@tech9.net>
From: Linux maillist account <l-k@mindspring.com>
Subject: Re: a nohup-like interface to cpu affinity
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1006836589.842.4.camel@phantasy>
In-Reply-To: <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com>
 <E16744i-0004zQ-00@localhost>
 <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
 <1006472754.1336.0.camel@icbm>
 <E16744i-0004zQ-00@localhost>
 <5.0.2.1.2.20011126231737.009f0ec0@pop.mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:49 PM 11/26/01 -0500, Robert Love wrote:
>I can see the use for this, but you can also just do `echo whatever >
>/proc/123/affinity' once it is running ... not a big deal.


It's isn't quite the same..the biggest difference is races.  The cpuselect(1)
tool would change the affinity mask before the fork & exec of the first 
child.  To
do this by hand via an `echo whatever >/proc/123/affinity' would miss all the
children spun off by 123 before the echo could be executed.  One could write
cpuselect as a shell script I suppose, using within it an echo on 
/proc/self/affinity,
though even as a shell script it would be better to have this tool be part 
of the standard
Linux repetoire that everyone could depend upon as being there in all Linux 
distributions
and having a well known and unchanging syntax and semantics,  rather than 
have it
remain something that each user creates ad-hoc as the need for the tool arises.

Joe


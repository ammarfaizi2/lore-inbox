Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281657AbRKQAFJ>; Fri, 16 Nov 2001 19:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281661AbRKQAFA>; Fri, 16 Nov 2001 19:05:00 -0500
Received: from [208.129.208.52] ([208.129.208.52]:54021 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S281659AbRKQAEt>;
	Fri, 16 Nov 2001 19:04:49 -0500
Date: Fri, 16 Nov 2001 16:13:57 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: Mike Kravetz <kravetz@us.ibm.com>, <lse-tech@lists.sourceforge.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Real Time Runqueue
In-Reply-To: <200111162241.QAA98422@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.40.0111161555120.998-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Jesse Pollard wrote:

> I believe we opted to leave all process in the queues to speed up the
> state change procedures. The selection process was always at the end of

I believe in that too, expecially if a good RT tasks distribution is
achieved.



> I always liked the trick of converting the bit vector to a floating point to
> use the exponent to determine the active queue - it took far fewer instructions
> than a loop to check each queue in an array. The added overhead when doing

Smart trick but by doing it in Linux needs you to get the fpu status
before doing the fp op otherwise you're going to do the fpu status
save/restore each time.




- Davide



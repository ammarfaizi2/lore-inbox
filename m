Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRAITR4>; Tue, 9 Jan 2001 14:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131440AbRAITRq>; Tue, 9 Jan 2001 14:17:46 -0500
Received: from [216.151.155.116] ([216.151.155.116]:65290 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S131369AbRAITRc>; Tue, 9 Jan 2001 14:17:32 -0500
To: Mihai Moise <mcartoaj@mat.ulaval.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: adding a system call
In-Reply-To: <200101091441.JAA12925@taylor.mat>
From: Doug McNaught <doug@wireboard.com>
Date: 09 Jan 2001 14:17:26 -0500
In-Reply-To: Mihai Moise's message of "Tue, 9 Jan 2001 09:41:21 -0500 (EST)"
Message-ID: <m3snmsbkmx.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mihai Moise <mcartoaj@mat.ulaval.ca> writes:

> My system call idea is to allow a superuser process to request a mmap on
> behalf of an user process. To see how this would be useful, let us consider
> svgalib.

[...]

> With my new system call, a superuser process can set the graphics mode in a
> safe manner and then ask for an mmap of the video array into the application
> data segment.

Ummm, couldn't the the root process open the video device, then pass
the file descriptor (via AF_UNIX socket) to the user process?  The
user process would then call mmap() on the open file descriptor. 

I'm not *completely* sure this would work, but it would avoid creating 
a new system call if so.

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

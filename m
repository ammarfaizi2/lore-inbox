Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131079AbRAPMgc>; Tue, 16 Jan 2001 07:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131063AbRAPMgW>; Tue, 16 Jan 2001 07:36:22 -0500
Received: from chiara.elte.hu ([157.181.150.200]:20497 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130159AbRAPMgG>;
	Tue, 16 Jan 2001 07:36:06 -0500
Date: Tue, 16 Jan 2001 13:33:44 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: O_ANY  [was: Re: 'native files', 'object fingerprints' [was:
 sendpath()]]
In-Reply-To: <20010116061342.C12650@cadcamlab.org>
Message-ID: <Pine.LNX.4.30.0101161329230.947-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Jan 2001, Peter Samuelson wrote:

> [Ingo Molnar]
> > - probably the most radical solution is what i suggested, to
> > completely avoid the unique-mapping of file structures to an integer
> > range, and use the address of the file structure (and some cookies)
> > as an identification.
>
> Careful, these must cast to non-negative integers, without clashing.

if you read my (radical) proposal, the identification is based on a kernel
pointer and a 256-bit random integer. So non-negative integers are not
needed. (file-IO system-calls would be modified to detect if 'Unix file
descriptors' or pointers to 'native file descriptors' are passed to them,
so this is truly radical.)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

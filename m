Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279321AbRKIFPr>; Fri, 9 Nov 2001 00:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279303AbRKIFPj>; Fri, 9 Nov 2001 00:15:39 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:29961 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S279321AbRKIFP2>;
	Fri, 9 Nov 2001 00:15:28 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111090515.fA95F3g167348@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
To: linux-kernel@alex.org.uk
Date: Fri, 9 Nov 2001 00:15:03 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        viro@math.psu.edu (Alexander Viro), jfbeam@bluetopia.net (Ricky Beam),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk),
        linux-kernel@vger.kernel.org (Linux Kernel Mail List)
In-Reply-To: <964381385.1005245622@[195.224.237.69]> from "Alex Bligh - linux-kernel" at Nov 08, 2001 06:53:43 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux writes:
> [Albert Cahalan]

>> Design the kernel to make doing this difficult.
>> Define some offsets as follows:
>> 
>> # define FOO_PID 0
>> # define FOO_PPID 1
>> 
>> Now, how is anyone going to create "an extra inserted DWORD"
>> between those? They'd need to renumber FOO_PPID and any other
>> values that come after it.
>
> For instance, take the /proc/mounts type example, where
> each row is a sequence of binary values. Someone decides
> to add another column, which assuming it is a DWORD^W__u64,
> does exactly this, inserts a DWORD^W__u64 between the
> end of one record and the start of the next as far a
> poorly written parser is concerned.

That would be a botched design to begin with.

Each row becomes a separate binary file. They are distinct
records anyway. Splitting by column would be a poor choice.

> The brokenness is not due to the distinction between ASCII
> and binary. The brokenness is due the ill-defined nature
> of the format, and poor change control.

ASCII encourages ill-defined formats and poor change control.
People make assumptions about what is valid.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131083AbRADLAL>; Thu, 4 Jan 2001 06:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRADLAA>; Thu, 4 Jan 2001 06:00:00 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129641AbRADK7p>;
	Thu, 4 Jan 2001 05:59:45 -0500
Message-ID: <20010103233052.B9834@bug.ucw.cz>
Date: Wed, 3 Jan 2001 23:30:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking bug exploits
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org>; from Dan Aloni on Wed, Jan 03, 2001 at 11:13:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It is known that most remote exploits use the fact that stacks are
> executable (in i386, at least).
> 
> On Linux, they use INT 80 system calls to execute functions in the kernel
> as root, when the stack is smashed as a result of a buffer overflow bug in
> various server software.
> 
> This preliminary, small patch prevents execution of system calls which
> were executed from a writable segment. It was tested and seems to work,
> without breaking anything. It also reports of such calls by using
> printk.

Haha.

So exploit needs to call libc function to do dirty work for it. Not so
big deal.

Okay, it might do a trick and deter script kiddies; still it is even
weaker then non-executable stack patches.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRKHSyI>; Thu, 8 Nov 2001 13:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277552AbRKHSx7>; Thu, 8 Nov 2001 13:53:59 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:28080 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277541AbRKHSxw>;
	Thu, 8 Nov 2001 13:53:52 -0500
Date: Thu, 08 Nov 2001 18:53:43 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@alex.org.uk
Cc: Alexander Viro <viro@math.psu.edu>, Ricky Beam <jfbeam@bluetopia.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <964381385.1005245622@[195.224.237.69]>
In-Reply-To: <200111080047.fA80lxk105204@saturn.cs.uml.edu>
In-Reply-To: <200111080047.fA80lxk105204@saturn.cs.uml.edu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Design the kernel to make doing this difficult.
> Define some offsets as follows:
>
># define FOO_PID 0
># define FOO_PPID 1
>
> Now, how is anyone going to create "an extra inserted DWORD"
> between those? They'd need to renumber FOO_PPID and any other
> values that come after it.

For instance, take the /proc/mounts type example, where
each row is a sequence of binary values. Someone decides
to add another column, which assuming it is a DWORD^W__u64,
does exactly this, inserts a DWORD^W__u64 between the
end of one record and the start of the next as far a
poorly written parser is concerned.

The brokenness is not due to the distinction between ASCII
and binary. The brokenness is due the ill-defined nature
of the format, and poor change control. (so for instance
the ASCII version could consistently use (say) quoted strings,
with spaces between fields, and \n between records, just
as the binary version could have a record length entry at the
head of each record, and perhaps field length and identifier
versions by each field - two very similar solutions to the
problem above).

> The "DWORD" idea is messed up too BTW. Use __u64 everywhere.

OK OK :-)

--
Alex Bligh

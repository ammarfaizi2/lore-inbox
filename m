Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAIRDS>; Tue, 9 Jan 2001 12:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129573AbRAIRC7>; Tue, 9 Jan 2001 12:02:59 -0500
Received: from yoda.planetinternet.be ([195.95.30.146]:40202 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S129406AbRAIRCt>; Tue, 9 Jan 2001 12:02:49 -0500
Date: Tue, 9 Jan 2001 18:02:39 +0100
From: Kurt Roeckx <Q@ping.be>
To: Andries.Brouwer@cwi.nl
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010109180239.A3342@ping.be>
In-Reply-To: <UTC200101082250.XAA147777.aeb@texel.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <UTC200101082250.XAA147777.aeb@texel.cwi.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 11:50:44PM +0100, Andries.Brouwer@cwi.nl wrote:
>     From: Andrea Arcangeli <andrea@suse.de>
> 
>     > But in fact it fails with EINVAL, and
>     > 
>     > [EINVAL]: The path argument contains a last component that is dot.
> 
>     I can't confirm. The specs I'm checking are here:
> 
>         http://www.opengroup.org/onlinepubs/007908799/xsh/rmdir.html
> 
> That is the SUSv2 text, one of the ingredients for the new
> POSIX standard. I quoted the current Austin draft, the current
> draft for the next version of the POSIX standard.
> 
> Quoting a text fragment:
> 
>         The rmdir( ) function shall remove a directory whose name is given by
>         path. The directory is removed only if it is an empty directory.
>         If the directory is the root directory or the current working
>         directory of any process, it is unspecified whether the function
>         succeeds, or whether it shall fail and set errno to [EBUSY].
>         If path names a symbolic link, then rmdir( ) shall fail and
>         set errno to [ENOTDIR]. If the path argument refers to a path
>         whose final component is either dot or dot-dot, rmdir( ) shall
>         fail. ...

At the bottom of Andrea Arcangeli's url, it says:
Derived from the POSIX.1-1988 standard.

I think it makes sense that if POSIX changed it, that we should
follow POSIX, and not SuS v2, specially if it simplify's things
in the kernel.


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313341AbSC2M51>; Fri, 29 Mar 2002 07:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313374AbSC2M5R>; Fri, 29 Mar 2002 07:57:17 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:24706 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313341AbSC2M5I>; Fri, 29 Mar 2002 07:57:08 -0500
Date: Fri, 29 Mar 2002 12:57:07 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Padraig Brady <padraig@antefacto.com>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
In-Reply-To: <3CA45BEC.8030106@antefacto.com>
Message-ID: <Pine.SOL.3.96.1020329124320.18653A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002, Padraig Brady wrote:
> Is this a good default?

I don't see what's wrong with that. It follows the logic of least
surprise. In Windows all files are executable as there is no way to
distinguish executables from non-executables due to lack of executable
bit. NTFS on Linux has no way of telling the difference either and hence
it makes sense to allow execution of all files.

If you don't like it, use -o noexec,fmask=0111 and you will not have any
files being executable.

> IMHO you usually would not want to execute stuff off NTFS, and
> if you do you can always just explicitly invoke using wine like:
> `wine /ntfs/lookout.exe`

No you couldn't.

> To have all files executable breaks stuff like:
> midnight commander (won't open executable files)

Ouch, that is plain stupid... mc should be fixed. I open executables all
the time and mc should automatically fire up a hexeditor.

> ls colorizing

I like green files. (-;

> shell tab completion

Heh?!? Works for me. Fix your shell settings.

> ...

Like what?

> see:
> http://marc.theaimsgroup.com/?t=100143416100009&r=1&w=2

Read it. I still don't see any reason for not having x on files by
default.

> I think the default should be
> rx for directories and r for files

If you think so just use fmask to clear the x bit and be happy.

I guess if more people complain I can change the default fmask to be 0177
instead of 0077 but I want to see more complaints first. I personally find
the being able to execute behaviour better as I run things off the ntfs
partitions...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282779AbRK0EBf>; Mon, 26 Nov 2001 23:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282780AbRK0EBY>; Mon, 26 Nov 2001 23:01:24 -0500
Received: from femail39.sdc1.sfba.home.com ([24.254.60.33]:3507 "EHLO
	femail39.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282783AbRK0EBP>; Mon, 26 Nov 2001 23:01:15 -0500
Message-ID: <3C030FB4.C3303BE4@ecf.utoronto.ca>
Date: Mon, 26 Nov 2001 22:59:48 -0500
From: Mark Richards <richard@ecf.utoronto.ca>
Organization: Comp Eng. 0T1
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-kernel@vger.kernel.org
Subject: Multiplexing filesystem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick question, which I suspect has a long answer.

I would like to write a multiplexing filesystem.  The idea is as follows:

The filesystem would ideally wrap another filesystem, such as nfs or smbfs or
ext2.  Most operations would just be passed to the native fs call.  However, for
some files, selectable at run time by some control singal, would actually reside
on another file system.  The other filesystem would have to be mounted.

The idea is for a version controlling filesystem.  The server would be a network
server (hence the desire to wrap nfs) which presents a 'view' of the source
code.  When the user reserves a file for editing, the file is copied to the
local disk.  From that point on, the local file is referred to until the user
commits the change or unreserves the file.  Ideally, the local copy of the file
could be on any file system, not one that is necessarily local.  And this has to
be totally transparent to the user, except for the step where the user
'reserves' the file.

I've thought about two ways to do this.  One is to wrap the 'versioning' file
system with a multiplexor that checks fs calls to see if they are referring to a
file that is on a different fs.  The other approach is to intercept calls to the
VFS to do the same trick.

I'm new to the whole filesystem-coding thing, so bear with me if what i've just
said makes no sense.  So, my question (I guess it wasn't quick after all) is:
Can it be done, and are either of my two approaches feasible?  Any suggestions
or tips?

Thanks,
Mark Richards

PS please CC me if possible.


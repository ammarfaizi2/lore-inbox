Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbRDUJVQ>; Sat, 21 Apr 2001 05:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132552AbRDUJVG>; Sat, 21 Apr 2001 05:21:06 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:5540 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132547AbRDUJVD>; Sat, 21 Apr 2001 05:21:03 -0400
Message-Id: <5.0.2.1.2.20010421100423.03d2fd30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sat, 21 Apr 2001 10:23:27 +0100
To: lee@ricis.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Current status of NTFS support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01042021072007.00845@linux>
In-Reply-To: <m34rvjuj3y.fsf@belphigor.mcnaught.org>
 <86256A34.0079A841.00@smtpnotes.altec.com>
 <01042020185806.00845@linux>
 <m34rvjuj3y.fsf@belphigor.mcnaught.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:07 21/04/2001, Lee Leahu wrote:
>On Friday 20 April 2001 20:39, you wrote:
> > Lee Leahu <lee@ricis.com> writes:
>my boss rememebres reading a very indepth article in one of the msdn
>magazines.  i could scan the articles in and compress them and send them 
>to the developers.

Since you can access the library for free at msdn.microsoft.com/library 
that would be a waster of your time. Just give the references to the 
article. If however you mean the "inside NTFS" and "inside Windows 2000 
NTFS" by Mark Russinovich then yes they are great but no they are not 
in-depth enough in that you have to complete the picture by mapping his 
"logical" information to the actual "physical" on disk information. Which 
admittedly is not that difficult with NTFS DiskEdit or any other hex editor 
most of the time... That's how I got the system files indexing keys and 
indexed data, the format of $Secure, etc, etc... (-;

I would be surprised if you are referring to any articles I haven't found 
yet but please try me. (-: I would be happy to have missed out some really 
cool article which gives even more information.

>i want to help the ntfs movement on linux.  would somebody be willing to 
>teach me the ropes of reverse engineering of software.  i am a faster 
>learner, and very interested in reverse engineering of software.

Do you understand assembly language? If not this is a _very_ long learning 
curve! Reverse engineering consists of three things:

1. Use a hexeditor or NTFS DiskEdit (provided by MS on NT4SP4 CD) and study 
the structures on disk and play with files, e.g. compress/uncompress, 
encrypt/decrypt, apply quotas, apply ACLs, and look at how the disk changes.

2. Use a disassembler (I use IDA Pro from www.datarescue.com/idapro, 
excellent product btw!) to get at the human readable form of ntfs.sys  and 
associated system files. Fortunately MS provides some debugging symbols on 
their web site which help a lot as they name some of the functions and 
global variables so you have some idea of what is going on right away. - 
This is extremely time consuming. - My current NTFS.sys disassembled file 
(from WinNT4 ntfs.sys) has 171460 lines! A _lot_ of code...

3. Use a kernel mode debugger (like SoftIce for example) and place break 
points inside the NTFS driver in memory and then trace execution to see 
what values are contained in some of the driver's variables, what functions 
call what, what they do, etc.

Without a working knowledge of assembly language points 2 and 3 are 
impossible...

>i have access to the msdn library and maganzies

So does everyone. They are free on the net.

>  and have lot of free time for dedicated ntfs code hacking.

Now that is cool. (-:

If you are really interested join the linux-ntfs project on Sourceforge. 
The documentation provided by the header files is the most in depth and 
most complete docs about NTFS you will ever find... You can use that 
knowledge to either help linux-ntfs development or just take the knowledge 
and use it to fix the existing driver instead. I welcome patches! [Make 
sure to download CVS and not the released version as that is very out of date.]

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


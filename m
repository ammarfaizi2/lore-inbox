Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313438AbSC2Nrj>; Fri, 29 Mar 2002 08:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313439AbSC2Nr3>; Fri, 29 Mar 2002 08:47:29 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:43910 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S313408AbSC2NrX>; Fri, 29 Mar 2002 08:47:23 -0500
Message-ID: <3CA4703C.8000900@antefacto.com>
Date: Fri, 29 Mar 2002 13:46:36 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
In-Reply-To: <Pine.SOL.3.96.1020329124320.18653A-100000@virgo.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> On Fri, 29 Mar 2002, Padraig Brady wrote:
> 
>>Is this a good default?
> 
> 
> I don't see what's wrong with that. It follows the logic of least
> surprise. In Windows all files are executable as there is no way to
> distinguish executables from non-executables due to lack of executable
> bit. NTFS on Linux has no way of telling the difference either and hence
> it makes sense to allow execution of all files.
> 
> If you don't like it, use -o noexec,fmask=0111 and you will not have any
> files being executable.
> 
> 
>>IMHO you usually would not want to execute stuff off NTFS, and
>>if you do you can always just explicitly invoke using wine like:
>>`wine /ntfs/lookout.exe`
> 
> 
> No you couldn't.
> 

why not? wine should be changed to allow this if
it is a limitation with it.

>>To have all files executable breaks stuff like:
>>midnight commander (won't open executable files)
> 
> 
> Ouch, that is plain stupid... mc should be fixed. I open executables all
> the time and mc should automatically fire up a hexeditor.

Well by not opening I meant it tries to run them
which is sensible really. I would guess any unix
filemanager is going to have some issues with all
files having executable bits set.

Isn't there some kludge for vfat where it marks
*.{com,exe,bat} as executable?

> 
>>ls colorizing
> 
> 
> I like green files. (-;

Well I hate them :-)
Also coloring is wrong in mc and probably other things.

> 
>>shell tab completion
> 
> 
> Heh?!? Works for me. Fix your shell settings.
>
> 
>>...
> 
> 
> Like what?
> 
> 
>>see:
>>http://marc.theaimsgroup.com/?t=100143416100009&r=1&w=2
> 
> 
> Read it. I still don't see any reason for not having x on files by
> default.
> 
> 
>>I think the default should be
>>rx for directories and r for files
> 
> 
> If you think so just use fmask to clear the x bit and be happy.
> 
> I guess if more people complain I can change the default fmask to be 0177
> instead of 0077 but I want to see more complaints first. I personally find
> the being able to execute behaviour better as I run things off the ntfs
> partitions...
> 
> Best regards,
> 
> 	Anton




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310468AbSCLHzG>; Tue, 12 Mar 2002 02:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310469AbSCLHy4>; Tue, 12 Mar 2002 02:54:56 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:24330 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S310468AbSCLHyv>; Tue, 12 Mar 2002 02:54:51 -0500
Message-ID: <3C8DB449.3020309@namesys.com>
Date: Tue, 12 Mar 2002 10:54:49 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: elenstev@mesatop.com
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing (If you don't like the closed source nature of Bitkeeper, stop your whining and help out with reiserfs.)
In-Reply-To: <Pine.LNX.4.33.0203110508080.17717-100000@mhw.ULib.IUPUI.Edu> <200203111755.KAA11787@tstac.esa.lanl.gov> <3C8D0260.8070700@namesys.com> <200203112048.NAA12104@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok guys, those of you who have been saying that somehow link, etc., will 
break and Unix cannot handle version control, I am sorry, Clearcase does 
all this stuff in the filesystem, and it more or less works, and their 
primary disadvantages are that they don't have reiserfs levels of 
performance, their software is not tight and clean which makes being a 
Clearcase Admin so much work that it funded the creation of Namesys, and 
they are an expensive closed source solution.  Once Josh's transactions 
are in place, we can start convincing application writers that rename is 
a sorry ass transactions API, and start thinking about coding basic 
version control in the FS.  My sysadmin thinks that views are the best 
security model for network service offering processes to run with, and I 
think he is right (chroot just isn't convenient enough to get used a lot 
in practice).

If you don't like the closed source nature of Bitkeeper, stop your 
whining and help out with reiserfs v5 (reiser5 development to start in 
October, reiser4 is a prereq for reiser5 and feature freeze for reiser4 
is in place).  In the meantime, give Larry a thank you for giving us 
something we wouldn't otherwise have and sorely need.  

Hans



Steven Cole wrote:

>On Monday 11 March 2002 12:15 pm, Hans Reiser wrote:
>
>>Steven Cole wrote:
>>
>>>I fiddled around a bit with VMS, and it looks like the following command
>>>set things up for me so that I only have one version for any new files I
>>>create:
>>>
>>>SET DIRECTORY/VERSION_LIMIT=1 SYS$SYSDEVICE:[USERS.STEVEN]
>>>
>>>This change was persistant across logins.  Hope this helps.
>>>
>>>Steven
>>>
>>This affects all directories and all files for user steven, or just one
>>directory?
>>
>
>The above example affected all subsequently created files and subsequently
>created directories under user steven, such as DKA300:[USERS.STEVEN.TESTTHIS].
>Previously created directories retain their previous version_limit setting, which
>I checked in DKA300:[USERS.STEVEN.HELLOWORLD].  Previously created files also
>retain their previous version_limit setting.
>
>I also set the version_limit for the whole disk (as SYSTEM) with 
>SET DIRECTORY/VERSION_LIMIT=1 DKA300:[000000], but again this only affected
>subsequently created files and directories along with the files they contain.
>
>I have not figured out how to set the version_limit retroactively; perhaps it is
>not possible with a simple command.  Obviously, you could do this with a DCL 
>script if you really wanted to.
>
>Steven
>
>

So it is fair to say that all those folks who were irritated by the VMS 
version control feature were just not VMS sophisticates.   Thanks Steven.


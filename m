Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSETTRp>; Mon, 20 May 2002 15:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316211AbSETTRo>; Mon, 20 May 2002 15:17:44 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:15630 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316210AbSETTRo>;
	Mon, 20 May 2002 15:17:44 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205201917.g4KJHWm29999@saturn.cs.uml.edu>
Subject: Re: suid bit on directories
To: pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)
Date: Mon, 20 May 2002 15:17:32 -0400 (EDT)
Cc: michael@hostsharing.net, pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard),
        linux-kernel@vger.kernel.org
In-Reply-To: <200205201403.JAA08246@tomcat.admin.navo.hpc.mil> from "Jesse Pollard" at May 20, 2002 09:03:28 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard writes:
> Michael Hoennig <michael@hostsharing.net>:
>> [Jesse Pollard???]

>>> No. You loose the fact that the file was NOT created by the user.
>>
>> the user in my example above would be wwwrun or httpd - and that does not
>> make any sense at all! It would make much more sense if the new files
>> belonged to the owner of the directory, who is the one who owns the
>> virtual host.
>
> You can't tell who the user is. ANY user would be able to do that.

If you have a setuid directory, then you accept responsibility
for anything that other people place in that directory.

If you are the admin, you hold the owner of a setuid directory
responsible for everything that gets put in it.

>>>> I do not even see a security hole if nobody other than the user itself
>>>> and httpd/web can reach this area in the file system, anyway. And it
>>>> is still the users decision that files in this (his) directory should
>>>> belong to him.
>>>
>>> 1. users will steal/bypass quota controls
>>
>> Not in my example - acutally even the other way around.
>
> And just how is it prevented? quotas are applied based on either group
> or user. Normally it is based on user. Once the uid is set, then the
> quotas start being deducted. If the the user procedes to store 10 G of
> music files, who is charged? And how do you know who put them there.

Duh, this is a web server.

If you really don't understand, then read up on dynamic
web stuff and web authentication:

cgi-bin, PHP, WebDAV, Java servlets, SSL...

>>> 2. Consider what happens if a user creates a file in such a directory
>>> and it is executable. - since the file is fully owned by a different
>>> user, it appears to have been created by that user. What protection
>>> mask is on the file? Can the creator (not owner) make it setuid?
>>> (nasty worm propagation method)

Oh please. Do you know that Linux supports a setgid bit
on directories? Well, it does, just the same as SysV.
Go ahead, try to get setgid for a group you aren't in.
Linux will even take away your setuid bit for trying.

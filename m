Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316374AbSETU6j>; Mon, 20 May 2002 16:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316373AbSETU6i>; Mon, 20 May 2002 16:58:38 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:51718 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S316371AbSETU6h>; Mon, 20 May 2002 16:58:37 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: suid bit on directories
Date: Mon, 20 May 2002 20:58:37 +0000 (UTC)
Organization: Cistron
Message-ID: <acbo1t$aoo$1@ncc1701.cistron.net>
In-Reply-To: <20020520165312.3fb29ba2.michael@hostsharing.net> <200205201928.OAA13328@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1021928317 11032 195.64.65.67 (20 May 2002 20:58:37 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200205201928.OAA13328@tomcat.admin.navo.hpc.mil>,
Jesse Pollard  <pollard@tomcat.admin.navo.hpc.mil> wrote:
>And ANY user can put files into YOUR directory. Even files you don't want
>there. AND you can't tell who did it.

A setuid bit on a directory doesn't mean it syddenly has
rwxrwxrwx permissions. You still need permission to create the
file as usual. Try playing with a setgid directory one day.
It behaves the same.

>> Only the owner of the directories can set this flag. There is nothing to
>> control. 
>
>Ah - so I can put files into your directory, and suddenly they are owned
>by you. Remember that the next time you are convicted of piracy with criminal
>data in your directory.... (DMCA remember - and saying "Those files are not
>mine" just doesn't cut it, when obviously they have your uid on them; the
>best you would work them down to is "contributing to piracy").

It would be stupid to have a setuid directory world writable. You'd
probably make it group writab;e. Then only people in that group have
access to create files, so the files aren't anonymous - they were
created by someone in that group.

>Also remember what happens when a hard link is created in the directory...
>The file changes ownership.

Adding an extra directory entry for a file doesn't change
the inode (well, the link count is bumped up by one) in any way.

Mike.
-- 
"Insanity -- a perfectly rational adjustment to an insane world."
  - R.D. Lang


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283220AbRLMJZk>; Thu, 13 Dec 2001 04:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283733AbRLMJZZ>; Thu, 13 Dec 2001 04:25:25 -0500
Received: from thebsh.namesys.com ([212.16.7.66]:43529 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S283220AbRLMJZM>; Thu, 13 Dec 2001 04:25:12 -0500
Message-ID: <3C1873A2.1060702@namesys.com>
Date: Thu, 13 Dec 2001 12:23:46 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C1678ED.8090805@namesys.com> <20011212204333.A4017@pimlott.ne.mediaone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Pimlott wrote:

>On Wed, Dec 12, 2001 at 12:21:49AM +0300, Hans Reiser wrote:
>
>>Naming conventions are easy.
>>
>
>Hans,
>
>While I look forward to your work, I think Anton points out some
>issues that you really should try to address now, only you have not
>understood them.  Can I take a crack at posing some concrete
>questions that manifest the issues?
>
>Let's imagine that we have a Linux system with an NTFS filesystem
>and a reiserfs4 filesystem.  You can make any tentative assumptions
>about reiserfs4 and new API's that you like, I just want to have an
>idea of how you envision the following working:
>
>First, I write a desktop application that wants to save an HTML file
>along with some other object that contains the name of the creating
>application.  The latter can go anywhere you want, except in the
>same stream as the HTML file.  The user has requested that the
>filename be /home/user/foo.html , and expects to be able to FTP this
>file to his ISP with a standard FTP program.  What calls does my
>application make to store the HTML and the application name?  If the
>answer is different depending on whether /home/user is NTFS or
>reiserfs4, explain both ways.
>
Are you sure that standard ftp will be able to handle extended 
attributes without modification?

One approach is to create a plugin called ..archive that when read is a 
virtual file consisting of an archive of everything in the directory. 
 It would be interesting I think to attach said plugin to standard 
directories by default along with several other standard plugins like 
..cat, etc.

>
>
>Second, I booted NT and created a directory in the NTFS filesystem
>called /foo .  In the directory, I created a file called bar.  I
>also created a named stream called bar, and an extended attribute
>called bar.  Now I boot Linux.  What calls do I make to see each of
>the three objects called bar?
>

You access /foo/bar, /foo/bar/,,bar, /foo/..bar by name.

>
>
>The heart of Anton's argument is that the UNIX filesystem name space
>is basically used up--there's just not much room to add new
>semantics.  The only obvious avenue for extension is, if /foo is not
>a directory, you can give some interpretation to /foo/bar .  But
>this doesn't help if /foo is a directory.  So something has to give,
>and we want to see what will give in reiserfs4.
>
>Andrew
>
>
Naming conventions are easy, but teaching user space is hard no matter 
whose scheme is used.



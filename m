Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310540AbSCGU7Z>; Thu, 7 Mar 2002 15:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310539AbSCGU7N>; Thu, 7 Mar 2002 15:59:13 -0500
Received: from imo-m06.mx.aol.com ([64.12.136.161]:25078 "EHLO
	imo-m06.mx.aol.com") by vger.kernel.org with ESMTP
	id <S310537AbSCGU7C>; Thu, 7 Mar 2002 15:59:02 -0500
Date: Thu, 07 Mar 2002 15:58:43 -0500
From: pelletierma@netscape.net
To: linux-kernel@vger.kernel.org
Subject: Re: ACL support
Message-ID: <3EA14851.578E6D9E.5016AB90@netscape.net>
X-Mailer: Atlas Mailer 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In response to a number of email I have received, I wanted to make
something clear:  I'm not out to compete with the bestbit implementation of 
ACLs over extended file attributes.  :-)

What I am offering is an alternative implementation of ACL support at the
VFS level, that remains independent of filesystem support for ACLs.  In
fact, my patch provides filesystem support for ramfs only at this time
(which was ideal for testing).

The extenteded attribute system as implemented is very good (and in fact
I am using it for a project of mine), and provide an excellent
infrastructure for implementing ext2 and ext3 support for ACL...  only
I beleive that providing an uniform interface and evaluation of ACLs that
remains independent of the filesystem is the Right Thing(tm).

Placing ACLs at the VFS level also allows subdivision of the traditional
rwx semantics.  In fact, people emailed me after testing my patch have
suggested additional subdivisions of access right that would be useful
for some other non persistent filesystems (proc and devfs) such as
giving a bit for ioctl()s.  And since my ACL system is based on VFS
inodes, it can be extended to sockets as well, which would make useful
connection and listen permissions, for instance.
I have not touched implementation of ACL for ext2 and ext3 yet /exactly/
because the bestbits extended attributes existed, and I felt the people
working on that code would be in an excellent position to interface with
my ACL support seamlessly.

Both codebases can be viewed as orthogonal, not competing.  That's the
way I chose to look at it, and I hope others can feel the same as well.

Happy coding.  :-)

-- Marc A. Pelletier

-- 




__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/


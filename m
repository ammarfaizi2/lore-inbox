Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273589AbRIUQJy>; Fri, 21 Sep 2001 12:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273601AbRIUQJo>; Fri, 21 Sep 2001 12:09:44 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:41446 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S273589AbRIUQJ2> convert rfc822-to-8bit; Fri, 21 Sep 2001 12:09:28 -0400
Message-Id: <200109211609.SAA08383@post.webmailer.de>
Content-Type: text/plain; charset=US-ASCII
From: Norbert Sendetzky <norbert@linuxnetworks.de>
Organization: Linuxnetworks
To: <linux-kernel@vger.kernel.org>
Subject: Implementing a new network based file system
Date: Fri, 21 Sep 2001 18:07:05 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I'm currently doing some research on implementiation of a new file 
system for my diplomathesis. It's about designing and implementing a 
network file system with security in mind. For those interested, 
there is a short introduction about why and how on my website (look 
at the Secure Internet File System section):

http://www.linuxnetworks.de/security/index.html

I have already studied ramfs sources for the basics and the sources 
of coda, nfs and smbfs to find out, what I have to do. Also I read 
all documentation I found about the VFS. But there are a few 
questions, where I couldn't find an answer:


My first question is related to the superblock:
There are six functions about inode handling. Each of the above 
network file systems (coda, nfs, smbfs) implements different 
functions:

coda: read_inode and clear_inode
nfs: read_inode, put_inode and delete_inode
smbfs: put_inode and delete_inode

When do I need which function? Why are they necessary at all when 
implementing a network file system? Can anyone explain the bigger 
scheme behind this to me?


My second question is around inode_operations:
Why does none of the network file systems implement the readlink, 
follow_link, truncate and getattr funtions? Does the server follow 
the symlink automatically if it is written to the storage medium and 
show only the resulting file?


I have even more questions, but I will do some more research and 
maybe I will find the answer by myself before I get kicked off this 
list because of submitting too much obvious questions... (at least 
obvious to you) ;-)

Thanks in advance


Norbert

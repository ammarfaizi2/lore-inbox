Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290932AbSASLLH>; Sat, 19 Jan 2002 06:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290934AbSASLK4>; Sat, 19 Jan 2002 06:10:56 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:37394 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290932AbSASLKr> convert rfc822-to-8bit; Sat, 19 Jan 2002 06:10:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: [question] implentation of smb-browsing: kernel space or user space?
Date: Sat, 19 Jan 2002 12:08:57 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16RtOX-0007Ao-00@mrvdom00.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think that using the smb-file-system with a user-space mounter like 
mkautosmb has the problem of bad scalability in large networks, because it 
scans the whole network before you can access one share.

Other approaches like the integration in KDE have the problem,  to be only 
useful for KDE-programs - that means shares connot be used by all programs. 
(e.g. xmms cannot play an mp3 residing on a smb-share under kde without using 
smbmount)

Therefore I had the idea, to implement this smb-browsing feature in kernel 
space. It will be a kind of network neighbourhood-filesytem with all 
computers as top level directories below the mount point.

The first step might be to glue the autofs with smbfs and add a kernel smb 
browser as a proof of concept.

My question is: Do you think, that this kind of filesystem is sensible, or do 
you think that smb-stuff has to be in user space. (for example using the 
filesystem in userspace approach, shown some weeks ago)?

If I get positive response I will try to implement this feature. As it will 
be my first work on implementing a file system it might take some time, but I 
think it is a good chance to learn a lot about the linux kernel.

greetings

Christian

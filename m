Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263904AbRFMRkE>; Wed, 13 Jun 2001 13:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263934AbRFMRjy>; Wed, 13 Jun 2001 13:39:54 -0400
Received: from cpe-66-1-45-23.az.sprintbbd.net ([66.1.45.23]:1286 "EHLO
	deming-os.org") by vger.kernel.org with ESMTP id <S263904AbRFMRji>;
	Wed, 13 Jun 2001 13:39:38 -0400
Message-ID: <3B27A546.A64F8B00@lycosmail.com>
Date: Wed, 13 Jun 2001 10:39:19 -0700
From: Russ Lewis <russl@lycosmail.com>
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Has it been done: User Script File System?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any filesystem in Linux that uses user scripts/executables to
implement the various function calls?  What I'm thinking of is something
along the lines of a file system module that, when it receives a call
from VFS, passes the information out to a user-mode daemon which could
then run scripts or executables to answer the question.  The daemon
would then return the answer to the module, and the module would answer
VFS.

The reason I'm wondering is that I have a lot of brainstorms about
things that might be cool to implement as filesystems, but I don't want
to take the time to have to implement a full filesystem for each
(especially considering the number of bugs and kernel panics I'm likely
to encounter in the process).  What I'd really like to do is something
like this:

mount -t userfs   /etc/myfs.conf   /myfs

Where /etc/myfs.conf would have something like this:

lookup:  /usr/bin/myfslookup
open:   /usr/bin/myfsopen
etc...

I know that it would be very slow, and might require some modifications
to VFS to make it work (in addition to the module I'd have to write),
but it would be really nice to be able to throw together a very simple
utility filesystem without having to worry about crashing the kernel.

Does Linux have anything even remotely like this?  If not, I might (if I
can spare the time) play around with something like this of my own.


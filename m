Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280982AbRKLUnK>; Mon, 12 Nov 2001 15:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280985AbRKLUnD>; Mon, 12 Nov 2001 15:43:03 -0500
Received: from mail.ifrsys.com ([65.196.219.164]:59149 "EHLO mail.ifrsys.com")
	by vger.kernel.org with ESMTP id <S280986AbRKLUmm>;
	Mon, 12 Nov 2001 15:42:42 -0500
Message-ID: <3BF0343C.2080409@ifrsys.com>
Date: Mon, 12 Nov 2001 14:42:36 -0600
From: "David D. Hagood" <David.Hagood@ifrsys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011022
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Automount FS re-exported via NFS fails
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a situation where I have a set of file systems that are automounted by 
the automount file system in 2.4.x under /misc. I'd like to make those file 
systems available via NFS from machine.

In the ideal case, I would have something like this in /etc/exports:
/misc 10.0.0.0/255.0.0.0 (rw)

Thus, a client machine could mount server:/misc as /somedir, and then cause a 
filesystem to be mounted by accessing /somedir/some_auto_filesystem.

However, that doesn't work, as the NFSD seems to want to do a getfh() IOCTL on 
the auto file system, and autofs doesn't seem to support that IOCTL.

(I can work around this by explicitly exporting each possible file system under 
/misc, and allowing clients to mount them directly, but this isn't the greatest 
solution.)

First, is anybody working on this? If not, I may try my hand at it.

Second, if nobody is working on it, anybody have pointers on a good file system 
to model a getfh() for autofs on?

Please CC me, as I'm not currently subscribed to the list.

#include <std_disclaimer>


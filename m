Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbTDFSos (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 14:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbTDFSos (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 14:44:48 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:5821 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S263063AbTDFSoq (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 14:44:46 -0400
Message-ID: <3E907A94.9000305@kegel.com>
Date: Sun, 06 Apr 2003 12:05:56 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: re: [PATCH] new syscall: flink
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich wrote:
> I got a couple of requests for a function which isn't support on Linux
> so far.  Also not supportable, i.e., cannot be emulated at userlevel.
> It has some history in other systems (QNX I think), though, and helps
> with some security issues.

How does this differ from fattach() in SuSv3
(http://www.opengroup.org/onlinepubs/007904975/functions/fattach.html)?
(i.e. does the fact that fattach() is defined only for streams
fds make a difference?)

Out of curiosity, I did some searching for prior mentions of flink.
It gets proposed every two years or so, it seems.
There may be some security issues.  Here are two posts that
might be of interest (I wouldn't know, I'm not a security guru):

http://marc.theaimsgroup.com/?l=linux-kernel&m=88944672732020&w=2
Malcolm Beattie <mbeattie () sable ! ox ! ac ! uk> wrote:
> SysV calls this fattach() where fd is a STREAMS file descriptor
> (usually a STREAMS pipe). For general file descriptors, it has
> security implications. For example, you mustn't let it be legal
> for a process to get a read-only file descriptor and then link
> it into the file system because then it could change the file's
> permissions to read-write.

http://mail-index.netbsd.org/tech-userlevel/2001/09/29/0000.html
Andrew Brown <atatat@atatdot.net> wrote:
 ># as for flink(2), no.  flink(2) would be a terribly bad idea.  consider
 ># that when opening a file, *all* the permissions on *all* the inodes in
 ># the path to the file are considered.  if you were able to get some
 ># process to hand you an open file descriptor to some file somewhere
 ># that relies on being protected by permissions in the path and you were
 ># able to flink(2) it to some arbitrary name, you could bypass the
 ># permissions set that had been established.

- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


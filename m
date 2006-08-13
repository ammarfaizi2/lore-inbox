Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWHMXIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWHMXIz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 19:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWHMXIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 19:08:55 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:19181 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751710AbWHMXIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 19:08:55 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       nfs@lists.sourceforge.net
Subject: Re: 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock manager!
Date: Mon, 14 Aug 2006 09:08:49 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <a0cvd2pooblre0okto0u58j1nu8c4n43p9@4ax.com>
References: <9a8748490608080739w2e14e5ceg44a7bf0a3b475704@mail.gmail.com> <ketid21n1s5bn108lo7ps9t8a85db5bgs9@4ax.com> <9a8748490608090107j6ce7bc2cr2b74cc13b9541f39@mail.gmail.com> <9a8748490608101537y4c377fb3xcd8babbdbc29cee2@mail.gmail.com>
In-Reply-To: <9a8748490608101537y4c377fb3xcd8babbdbc29cee2@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 00:37:35 +0200, "Jesper Juhl" <jesper.juhl@gmail.com> wrote:

>On 09/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>> On 09/08/06, Grant Coady <gcoady.lk@gmail.com> wrote:
>> > On Tue, 8 Aug 2006 16:39:54 +0200, "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>> >
>> > >I have some webservers that have recently started reporting the
>> > >following message in their logs :
>> > >
>> > >  do_vfs_lock: VFS is out of sync with lock manager!
>> > >
>> > >The serveres kernels were upgraded to 2.6.17.8 and since the upgrade
>> > >the message started appearing.
>> > >The servers were previously running 2.6.13.4 without experiencing this problem.
>> > >Nothing has changed except the kernel.
>> > >
>> > >I've googled a bit and found this mail
>> > >(http://lkml.org/lkml/2005/8/23/254) from Trond saying that
>> > >"The above is a lockd error that states that the VFS is failing to track
>> > >your NFS locks correctly".
>> > >Ok, but that doesn't really help me resolve the issue. The servers are
>> > >indeed running NFS and access their apache DocumentRoots from a NFS
>> > >mount.
>> > >
>> > >Is there anything I can do to help track down this issue?
>> >
>> > I don't have an answer, but offer this observation: five boxen running
>> > 2.6.17.8 doing six simultaneous
>> >
>> >   bzcat /home/share/linux-2.6/patch-2.6.18-rc4.bz2|patch -p1
>> >
>> > didn't burp.  The /home/share/ is an NFS export from another box running
>> > 2.4.33-rc3a, me not sure if this was exercising any NFS locking as the
>> > NFS source file was only opened for non-exclusive read-only.
>> >
>> The NFS server here is running 2.6.11.11 and doesn't seem to be
>> reporting any problems. But I now have two more of my webservers (both
>> running 2.6.17.8) that have started to complain about "do_vfs_lock:
>> VFS is out of sync with lock manager!"
>>
>> I've not found a way to cause the message to be repported at will unfortunately.
>>
>Today 3 more of my webservers running 2.6.17.8 reported this message.
>The machines all seem to be running fine still, so it doesn't seem to
>be a serious problem, but it would still be nice to get it fixed ;)

I'm running continuous kernel 2.4.33 rebuild from make mrproper plus 
another console extracting tarball, diff tree against last_extracted, 
on pair of 2.6.17.8 boxen overnight with NFS TCP support, no problems, 
now testing without TCP support.  Report again only if I see problems.  

Let me know if you want to see test scripts.

Grant.

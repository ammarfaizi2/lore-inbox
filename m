Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbUBZOZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 09:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUBZOZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 09:25:15 -0500
Received: from mail504.nifty.com ([202.248.37.212]:39888 "EHLO
	mail504.nifty.com") by vger.kernel.org with ESMTP id S262727AbUBZOZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 09:25:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: How to emulate 'chroot /jail/ su httpd -c' ?
From: Tetsuo Handa <a5497108@anet.ne.jp>
Message-Id: <200402262324.CJF97413.289B5186@anet.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Thu, 26 Feb 2004 23:24:46 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# Daily digest mail didn't arrive to me yesterday(2/25) and
# today(2/26), may be something is wrong with my mail server.
# Sorry for ignoring thread tree, this is a reply to
http://www.ussg.iu.edu/hypermail/linux/kernel/0402.3/0848.html

Ma*ns Rullga*rd wrote:
> Tetsuo Handa <a5497108@xxxxxxxxxx> writes:
> 
> > Hello,
> >
> > Sorry for querying userland program in this list.
> >
> > I have the following line in /etc/rc.d/init.d/httpd
> >
> > daemon chroot /jail/ su httpd -c $httpd $OPTIONS
> >
> > This needs /bin/su after /usr/sbin/chroot, but I don't
> > want to place /bin/su (and related files) in the jail.
> > So, I want to do this with one program.
> 
> If you remove the suid bit from the su program in the chroot it should
> be rather harmless.

Oh! What a nice idea! 
'chmod 500 /bin/su' is to the purpose.
Thank you.

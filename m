Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268252AbUHQOKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268252AbUHQOKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUHQOKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:10:07 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:16625 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268252AbUHQOIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:08:06 -0400
Message-ID: <2a4f155d040817070854931025@mail.gmail.com>
Date: Tue, 17 Aug 2004 17:08:06 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.8.1-mm1 Tty problems?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Watch this sequence :


cartman@southpark:~$ echo "foo" > foo
cartman@southpark:~$ cat foo
foo
cartman@southpark:~$ less foo
cartman@southpark:~$ 

As you see less doesn't show up anything. Strace shows this piece of info :

<snip>

open("/dev/tty", O_RDONLY|O_LARGEFILE)  = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbffff430) = -1 ENOTTY
(Inappropriate ioctl for device)

</snip>

Any ideas whats going on?

P.S : 2.6.8 was working just fine.


-- 
Time is what you make of it

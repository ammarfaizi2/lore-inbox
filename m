Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUHQSIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUHQSIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268367AbUHQSIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:08:10 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:50772 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268374AbUHQSIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:08:01 -0400
Message-ID: <412247FF.5040301@microgate.com>
Date: Tue, 17 Aug 2004 13:01:35 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1 Tty problems?
References: <2a4f155d040817070854931025@mail.gmail.com>
In-Reply-To: <2a4f155d040817070854931025@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ismail dönmez wrote:
> cartman@southpark:~$ echo "foo" > foo
> cartman@southpark:~$ cat foo
> foo
> cartman@southpark:~$ less foo
> cartman@southpark:~$ 
> 
> As you see less doesn't show up anything. Strace shows this piece of info :
> 
> <snip>
> 
> open("/dev/tty", O_RDONLY|O_LARGEFILE)  = 3
> ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbffff430) = -1 ENOTTY
> (Inappropriate ioctl for device)
> 
> </snip>
> 
> Any ideas whats going on?
> 
> P.S : 2.6.8 was working just fine.

Since this involves the controlling tty, try backing out
selinux-revalidate-access-to-controlling-tty.patch
(available in the broken-out mm patches)

--
Paul Fulghum
paulkf@microgate.com

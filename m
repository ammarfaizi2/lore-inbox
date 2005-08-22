Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVHVWWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVHVWWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVHVWWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:22:33 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45960 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751371AbVHVWWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:22:31 -0400
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6: halt instead of reboot
References: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee>
	<m14q9iva4q.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0508221152350.17731@math.ut.ee>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 22 Aug 2005 03:34:27 -0600
In-Reply-To: <Pine.SOC.4.61.0508221152350.17731@math.ut.ee> (Meelis Roos's
 message of "Mon, 22 Aug 2005 11:53:47 +0300 (EEST)")
Message-ID: <m1mznativw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> writes:

>> Does reboot=hard (on the kernel command line) change the behaviour?
>
> Will try in the evening.
>
>> Does magic sysrq work after the system hangs?
>
> It does not hang, it just powers off like on halt.

Ok. Then at least in part the kernel behavior is either
intersecting with a BIOS bug, a bad reboot script that calls halt instead,
or a driver that is scribbling on the wrong register.  There is
nothing in that code path that should remove the power.

>> Can you narrow it down to a -git snapshot where reboot breaks for
>> you?
>
> Quite hard - it's a production multiuser machine and gateway. Will see what I
> can find.

Ok. Until I have something to go on I don't have a clue where to start.

Eric


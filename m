Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbTF1XPN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbTF1XPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:15:13 -0400
Received: from main.gmane.org ([80.91.224.249]:51081 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265464AbTF1XPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:15:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: /dev/random broken?
Date: Sun, 29 Jun 2003 01:29:11 +0200
Message-ID: <yw1xk7b5u6go.fsf@zaphod.guide>
References: <3EFE2231.2050707@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
Cancel-Lock: sha1:3CdpwNxYWHsMCsj1hVkOd+4poyk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luca T." <luca-t@libero.it> writes:

> i am not sure if this is a kernel/module problem but so it seems to me.
> My computer is an AMD 2000+ with an ABIT motherboard, my kernel
> version is 2.4.21-0.13mdk (but i tried it with 2.4.21-0.18mdk too and
> it doesn't work either).
>
> If i give this command:
>   dd if=/dev/zero of=./xxx bs=1024 count=100
> it will work perfectly. But if i try to do the same reading from
> /dev/random with this command:
>   dd if=/dev/random of=./xxx bs=1024 count=100
> it will just sit there and stare at me until i move the mouse... and
> then the program will exit without any error message (i checked in
> /var/log/messages too and there is no message there either about this).
>
> Is this a bug? If yes... do you have any idea that would help me fix it?

It's not a bug.  The system needs to collect some randomness before
you can get any data.  The mouse is considered random, as are various
other devices.  If you need lots of random data, and are satisfied
with pseudo-random numbers, you can use /dev/urandom instead.

-- 
Måns Rullgård
mru@users.sf.net


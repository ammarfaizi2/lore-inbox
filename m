Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270658AbRHJWAZ>; Fri, 10 Aug 2001 18:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270657AbRHJWAF>; Fri, 10 Aug 2001 18:00:05 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:11532 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270656AbRHJWAA>; Fri, 10 Aug 2001 18:00:00 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Fri, 10 Aug 2001 14:59:37 -0700
Message-Id: <200108102159.f7ALxb908284@penguin.transmeta.com>
To: Axel.Thimm@physik.fu-berlin.de, linux-kernel@vger.kernel.org
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
Newsgroups: linux.dev.kernel
In-Reply-To: <20010810231906.A21435@bonzo.nirvana>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010810231906.A21435@bonzo.nirvana> you write:
>How can I reboot a stuck machine remotely, when there are uninterruptable
>processes arround? shutdown -r, reboot [-n] [-f], telinit 6 do not give the
>intended results. Localy I can use Alt-SysRq-S/U/B, but what if I still have a
>remote ssh connection and don't want to have to get to the machines location?
>
>Of course the real problem are the processes themselves, but being able to
>revive a machine is also nice ;)

You have to use the reboot() system call directly as root, with the
proper arguments to make it avoid doing even any sync. See

	man 2 reboot

for details.

		Linus

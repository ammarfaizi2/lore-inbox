Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268129AbRHKPKS>; Sat, 11 Aug 2001 11:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268123AbRHKPKJ>; Sat, 11 Aug 2001 11:10:09 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:7178 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S268079AbRHKPJ6>; Sat, 11 Aug 2001 11:09:58 -0400
Date: 11 Aug 2001 13:28:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <86efRRPHw-B@khms.westfalen.de>
In-Reply-To: <200108102159.f7ALxb908284@penguin.transmeta.com>
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <200108102159.f7ALxb908284@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 10.08.01 in <200108102159.f7ALxb908284@penguin.transmeta.com>:

> In article <20010810231906.A21435@bonzo.nirvana> you write:
> >How can I reboot a stuck machine remotely, when there are uninterruptable
> >processes arround? shutdown -r, reboot [-n] [-f], telinit 6 do not give the
> >intended results. Localy I can use Alt-SysRq-S/U/B, but what if I still
> >have a remote ssh connection and don't want to have to get to the machines
> >location?
> >Of course the real problem are the processes themselves, but being able to
> >revive a machine is also nice ;)
>
> You have to use the reboot() system call directly as root, with the
> proper arguments to make it avoid doing even any sync. See
>
> 	man 2 reboot
>
> for details.

I thought that was exactly what reboot -n -f does: don't sync, don't call  
shutdown, just reboot immediately. That's certainly what I have  
(successfully) used that for in the past.

MfG Kai

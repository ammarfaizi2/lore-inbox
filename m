Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUCPMYC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 07:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUCPMYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 07:24:02 -0500
Received: from mail.gmx.de ([213.165.64.20]:45801 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261803AbUCPMX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 07:23:58 -0500
Date: Tue, 16 Mar 2004 13:23:57 +0100 (MET)
From: "Marc Giger" <gigerstyle@gmx.ch>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20040316020035.A4123@jurassic.park.msu.ru>
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
X-Priority: 3 (Normal)
X-Authenticated: #1226656
Message-ID: <5124.1079439837@www16.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Mar 15, 2004 at 07:02:49PM +0100, Marc Giger wrote:
> > How long did you let your machine run?
> 
> $ uptime
>  01:40:40 up 3 days,  6:31,  4 users,  load average: 25.23, 24.16, 23.73
> 
> It's with unpatched 2.6.4. Before that the machine was running 2.6.1-rc1
> for 2 months.
> 
> > In my case, it has to run the whole night until it happens.
> 
> Perhaps there is a memory leak somewhere, and your systems just
> starts swapping.

No, that isn't the case. The memory usage stays constant and it has no swap
used at all.

> 
> > I don't know if it helps but I think the
> > first processes that are in uninterruptible sleep are apache and mysql.
> > Also, as you can see in my first e-mail (ps -aux output), the pdflush
> > and kswapd0 are in in uninterruptible sleep state.
> 
> Well, I can see something like that when I compile kernel with "make -j
> 15".
> The system starts swapping like crazy, most processes are in the D-state
> waiting for disk, but all goes back to normal after compilation is
> finished.
> What's wrong with it? :-)

Nothing when it would switch back to a normal state.:-) As I already
mentioned when processes begins to hang, all file operations like tail -f
/var/log/messages etc. then hangs too:-( Not even a login or a proper shutdown will
work. I have to press CTRL-SYSRQ-X

So I think it is something wrong with 2.6 on alpha:-) I have absolutely no
problems with 2.4.

Regards

Marc

-- 
+++ NEU bei GMX und erstmalig in Deutschland: TÜV-geprüfter Virenschutz +++
100% Virenerkennung nach Wildlist. Infos: http://www.gmx.net/virenschutz


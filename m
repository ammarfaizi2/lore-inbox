Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbUALUvT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUALUvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:51:19 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:62651 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S265283AbUALUvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:51:17 -0500
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Bart Samwel <bart@samwel.tk>
Cc: Kai Krueger <kai.a.krueger@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <4002F627.8000508@samwel.tk>
References: <200401121707.i0CH7iQ11796@mailgate5.cinetic.de>
	 <4002F627.8000508@samwel.tk>
Content-Type: text/plain
Organization: iNES Group
Message-Id: <1073940669.30991.7.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 12 Jan 2004 22:51:09 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (Mailbox)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 21:31, Bart Samwel wrote:
> Kai Krueger wrote:
> > I'm currently trying kernel 2.6.1-mm1 with laptop-mode on a reiserfs partition.
> > If I kill all daemons running on the system and do nothing with it, I can achieve the 10 minutes spin down time I had expected from laptop-mode. However as soon as I start up X with KDE I get regular spin ups every 30 seconds. Looking at the output of "echo 1 > /proc/sys/vm/block_dump", I see an entry every 30 seconds of "kdeinit(15145): WRITE block 65680 on hda1" followed by a whole load of "reiserfs/0(12): dirtied page" and "reisers/0(12): WRITE block XXXXX on hda1".
> > 
> > Due to the regular 30 second interval writes of kdeinit: kded to block 65680, laptop-mode is not particularly usable on this system.
> > Is this a problem with reiserfs or with kde and is there any fix available?
> 
> Can you take a look at the message that Dumitru Ciobarcianu just sent to 
> the list (about syslog), and check if it's that?

Won't help him if kdeinit is doing fsync() on every friggind write.
syslog has an option to disable that, that's all.

That's what evolution was doing until some friends helped me build an
fsync "NOP" wrapper .

This e-mail is written using "LD_PRELOAD=no-fsync.so evolution", and the
disc does not spin up every time I switch to another folder or just
another e-mail.

(Yeah, I know it's not an good ideea if I care about my e-mail, but I
keep backups... :)

Now I wonder what will happen if I do this system-wide...

hmmm... candy...

-- 
Cioby - "kids, don't try this at home"



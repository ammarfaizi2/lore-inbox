Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUHBMC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUHBMC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUHBMC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:02:26 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:34934 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S266487AbUHBMCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:02:25 -0400
Date: Mon, 2 Aug 2004 12:02:21 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>, minyard@acm.org
Subject: Re: IPMI watchdog question
In-Reply-To: <200407281246.27304.arekm@pld-linux.org>
Message-Id: <Pine.LNX.4.58.0408021119320.31915@praktifix.dwd.de>
References: <Pine.LNX.4.58.0407280901330.31636@praktifix.dwd.de>
 <200407281129.22431.arekm@pld-linux.org> <Pine.LNX.4.58.0407281021530.31636@praktifix.dwd.de>
 <200407281246.27304.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Arkadiusz Miskiewicz wrote:

> On Wednesday 28 of July 2004 12:33, Holger Kiehl wrote:
> 
> > > Do you have CONFIG_WATCHDOG_NOWAYOUT enabled?
> >
> > No this is not set. Must this be set? Actually I want that one can stop the
> > watchdog gracefully. And this is done by writting a 'V' to /dev/watchdog,
> > correct?
> Without CONFIG_WATCHDOG_NOWAYOUT (or nowayout=1 module option added by my 
> patch just sent to lkml) when /dev/watchdog is closed then watchdog timer is 
> disabled.
> 
Ok, with CONFIG_WATCHDOG_NOWAYOUT the system gets it reset. However now
there is no save way to stop the watchdog gracefully. It no longer honors
the magic letter 'V', but looking at the code of ipmi_watchtog.c I could
find no place where it looks for the magic character 'V'. So I am still not
sure what to do. The reason why I killed the process writting the heartbeat
was that I just wanted to see if the watchdog does work. Or is there a
simpler way to simulate a system hangup?

Thanks,
Holger

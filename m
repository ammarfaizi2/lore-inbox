Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVAaVA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVAaVA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVAaVAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:00:25 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:35810 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261361AbVAaU6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:58:35 -0500
Message-ID: <41FE9F7F.5F9E5F93@gte.net>
Date: Mon, 31 Jan 2005 13:13:35 -0800
From: Bukie Mabayoje <bukiemab@gte.net>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: sfeldma@pobox.com, "David =?iso-8859-1?Q?H=E4rdeman?=" <david@2gen.com>,
       Michael Gernoth <simigern@stud.uni-erlangen.de>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
References: <20050130171849.GA3354@hardeman.nu> <1107143255.18167.428.camel@localhost.localdomain> <41FDB2D3.5CBD6F7D@gte.net> <20050131152431.GA14176@logos.cnet>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [66.199.68.159] at Mon, 31 Jan 2005 14:58:26 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

> On Sun, Jan 30, 2005 at 08:23:47PM -0800, Bukie Mabayoje wrote:
> >
> > Scott Feldman wrote:
> >
> > > On Sun, 2005-01-30 at 09:18, David Härdeman wrote:
> > > > I experience the same problems as reported by Michael Gernoth when
> > > > sending a WOL-packet to computer with a e100 NIC which is already
> > > > powered on.
> > >
> > > I didn't look at the 2.4 case, but for 2.6, it seems e100 was enabling
> > > PME wakeup during probe.  PME shouldn't be enabled while the system is
> > > up.  I suspect the assertion of PME while the system is up is what's
> > > causing problems.  This patch moves PME wakeup enabling to either
> > > suspend or shutdown.
> > >
> > > David, would you give this patch a try?  Make sure the system still
> > > wakes from a magic packet if suspended or shut down, and doesn't cause
> > > kacpid to go crazy if system is running.  If it helps for 2.6, perhaps
> > > someone can look into 2.4 to see if there is something similar going on
> >
> > This issue was reported on 2.4.
>
> Can any of you guys test v2.6, please?

I will be glad to test it now but I can't, I am currently doing some work on 2.4. If no one has tested it in the next few days I will validate it then.

By the way,  do anyone have an idea how to get this functionality into 2.4 eepro100. The problem is that eepro100 code works on a non WOL cards.

>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268185AbUHQL0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268185AbUHQL0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUHQL0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:26:41 -0400
Received: from pop.gmx.net ([213.165.64.20]:37330 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268185AbUHQL0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:26:38 -0400
X-Authenticated: #1725425
Date: Tue, 17 Aug 2004 13:41:33 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: alan@lxorguk.ukuu.org.uk, jwendel10@comcast.net,
       linux-kernel@vger.kernel.org, Kai.Makisara@kolumbus.fi
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Message-Id: <20040817134133.56614674.Ballarin.Marc@gmx.de>
In-Reply-To: <4121A689.8030708@bio.ifi.lmu.de>
References: <411FD919.9030702@comcast.net>
	<20040816143817.0de30197.Ballarin.Marc@gmx.de>
	<1092661385.20528.25.camel@localhost.localdomain>
	<20040816231211.76360eaa.Ballarin.Marc@gmx.de>
	<4121A689.8030708@bio.ifi.lmu.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004 08:32:41 +0200
Frank Steiner <fsteiner-mail@bio.ifi.lmu.de> wrote:

> So what's the target in this process? Should users finally be able to
> write cds again without or only with suid bit set? It would be good to
> know if I should try to set all cd writing applications suid or just
> have to wait for some patches coming up that would allow users to
> write cds without suid again...
> 
> If the programs must be set suid, is that safe? In the past I was
> always told that setting e.g. cdrecord suid was a possible security
> issue.

An unpatched cdrecord does not use root privileges to access devices. It
increases its priority, locks memory and drops privileges before doing
anything else. According to its author, cdrecord is designed for this mode
of operation. I don't know if the same is true for growisofs and other
tools.
suid has no effect on the issue at hand (provided cdrecord has not
been modified), it only serves to increase burning reliability.

Regards

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264720AbUD1KUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264720AbUD1KUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 06:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264721AbUD1KT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 06:19:59 -0400
Received: from stingr.net ([212.193.32.15]:28879 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S264720AbUD1KT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 06:19:58 -0400
Date: Wed, 28 Apr 2004 14:19:54 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
Message-ID: <20040428101954.GK14129@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org> <20040427010748.GY17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net> <1083070293.30344.116.camel@watt.suse.com> <Pine.LNX.4.58.0404271500210.27538@alpha.polcom.net> <20040427140533.GI14129@stingr.net> <20040427183410.GZ17014@parcelfarce.linux.theplanet.co.uk> <20040427200459.GJ14129@stingr.net> <20040427202813.GA17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20040427202813.GA17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to viro@parcelfarce.linux.theplanet.co.uk:
> ... without saying anything?

Actually, it puts corresponding messages into /var/log/evms-engine.log
> 
> Well, AFAICS that means
> 	a) either kernel side of the things or the userland tools should
> printk/syslog - at least that evms device had been set up
> 	b) any distribution that runs this from initrd/init scripts would
> better take care of having sane fstab.
> 	c) nobody sane should put that as default.  Oh, wait, it's gentoo
> we are talking about?  Nevermind, then.

I think it is a really minor problem, comparing to others we sometimes
have. It has many solutions, for example, we can create
native device nodes in /dev/evms (or map on top of partitions).

There's a reason why this problem never arised before in such manner.
Traditional evms audience is server admins, and most of them configure
their boxes that disks other than with they /dev/root are
"evms-native" in some manner, and excluding their /dev/sda from evms
scan.

So for now, correct solution would be correct exclude device list, and
maybe distributions shipping evms will do this.

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head

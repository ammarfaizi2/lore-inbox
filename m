Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUIEVqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUIEVqb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 17:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUIEVqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 17:46:31 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:13074 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267251AbUIEVq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 17:46:29 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Stuart Young <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org,
       Rohit Neupane <rohitneupane@gmail.com>
Subject: Re: Weird Problem with TCP
Date: Mon, 6 Sep 2004 00:46:22 +0300
User-Agent: KMail/1.5.4
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <93e09f0104090202216403c08d@mail.gmail.com> <93e09f0104090206334a708289@mail.gmail.com> <200409030106.24476.cef-lkml@optusnet.com.au>
In-Reply-To: <200409030106.24476.cef-lkml@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409060046.22544.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Are you using session tracking. The symptoms you describe are
> > > classically those of session tracking nat/firewalling/whatever running
> > > out of table entries and being unable to allow new connections.
> >
> > No, it is not running any session tracking (ip_conntrack) neither it
> > does nat. It is just a firewall with around 1600 rules in FORWARD
> > mangle table and around 1500 rules in FORWARD filter table. Out of
> > 1500 rules , 1377 rules are MAC filter rules.
> > And it had 3 alias address for the interface conneted to the wirelss.
>
> EEEEK! 1600? That is insane!
>
> Consider cutting your rules into sections, and jumping to other tables to
> do sections of the work. Perhaps you can filter on the start of the MAC
> address and break this into smaller sections?
>
> Also of note: MAC addresses are easily spoofed, so if you're using this to
> lock out people on wireless, forget it, it doesn't work. Get them to use

Yes. I saw MAC filtering being hacked by a teenager with WinXP.
I inflicted OpenVPN on him. Now hack *that*, boy... ;)

> tunnels (eg: ipsec) instead. The only real way MAC addresses even sort of
> work is when you're providing a hotspot, ie: where you can't guarantee the
> client to have anything apart from base wireless, and you should therefore
> keep a tight leash on users connections by either timing them out
> regularly, or making them keep open a https:// page to a login/AAA server
> (ie: a page that auto-refreshes - when they stop refreshing the page,
> consider their connection stale).
--
vda


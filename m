Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbSLCUUs>; Tue, 3 Dec 2002 15:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbSLCUUs>; Tue, 3 Dec 2002 15:20:48 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49669 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265628AbSLCUUr>; Tue, 3 Dec 2002 15:20:47 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Quad ethernet card getting assigned different channels every
 install
Date: 3 Dec 2002 20:26:58 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <asj42i$6vi$1@gatekeeper.tmr.com>
References: <3DECBCA7.2010502@earthlink.net> <3DECC289.2050500@vgertech.com>
X-Trace: gatekeeper.tmr.com 1038947218 7154 192.168.12.62 (3 Dec 2002 20:26:58 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3DECC289.2050500@vgertech.com>,
Nuno Silva  <nuno.silva@vgertech.com> wrote:
| Hi!
| 
| You can load the module and specify the I/O address of each mii. This 
| way you'll allways get the same eth for a given I/O. Read the module's 
| fine manual :)

| Ian S. Nelson wrote:

| > The kernel is 2.4.18, from Redhat. I've looked at some of the code and I 
| > think this might actually be a hardware bug.  I'm helping setup a 3 port 
| > firewall, I'm remote so I haven't been hands on,  the guy has a quad 
| > ethernet card in it.  Between kernel installs eth0, eth1, eth2, and eth3 
| > seem to change which socket on the card they are.

It's not clear if the association of the name (ethN) to the io address
changes or the association of the io address to the connector. If Ian
will clarify, and perhaps check the ifconfig after a few boots...

If it's the name to io address mapping, and I assume it is, then Nuno
has the right idea, an options statement in modules.conf or on a command
line. If it's the latter the the BIOS is NOT doing deterministic
assignment. That would show in lspci with -vv, I believe. You could
still fix this, but it would be ugly, parsing lspci output and building
a command line for insmod.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSG3Vlc>; Tue, 30 Jul 2002 17:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSG3VlP>; Tue, 30 Jul 2002 17:41:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44496 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316662AbSG3VkI>;
	Tue, 30 Jul 2002 17:40:08 -0400
Date: Tue, 30 Jul 2002 14:42:06 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Federico Sevilla III <jijo@free.net.ph>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unkillable processes stuck in "D" state running forever
In-Reply-To: <20020730031321.GH1796@leathercollection.ph>
Message-ID: <Pine.LNX.4.33L2.0207301439270.2427-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Federico Sevilla III wrote:

| On Mon, Jul 29, 2002 at 09:13:33AM -0700, Randy.Dunlap wrote:
| > On Mon, 29 Jul 2002, Denis Vlasenko wrote:
| > | It is logged by syslog. /var/log/messages if your conf is standard.
| > That helps on the output side, sure, but I (mis?)understood the question
| > to be about the ability to do Alt-SysRq-x via ssh.  Is that possible?
|
| No you didn't misunderstand my question. Alt-SysRq-x via ssh doesn't
| work, and that's what I was wondering about. :)
|
| > Not that I know of, but I could be wrong about that.
| > So if you really need Alt-SysRq over a network connection (or even
| > a serial console connection)...
| > A few months ago I cooked up a patch so that "echo {magickey}"
| > mimics SysRq via proc/sysctl.  Patch against 2.4.18 is here:
| >   http://www.osdl.org/archive/rddunlap/patches/sys-magic.dif
| > Usage is:  echo {key} > /proc/sys/kernel/magickey
|
| I'm curious: can anyone logged on do this? With the physical Alt-SysRq-x
| people have to actually go into the server room, up to the server,
| connect a keyboard, and do their mumbo-jumbo. With this anybody can say,
| unmount all filesystems, right?
|
| :(

The 'magickey' /proc file is mode 0644 (read-write for root, read-only
for others), so jo_user can't write to it.

| But thanks, anyway. I'm thinking about whether or not I should do this
| (and just restrict logins to root, or something like that).

Sure.

-- 
~Randy


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268029AbTBYQcg>; Tue, 25 Feb 2003 11:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268030AbTBYQcg>; Tue, 25 Feb 2003 11:32:36 -0500
Received: from air-2.osdl.org ([65.172.181.6]:51110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268029AbTBYQcf>;
	Tue, 25 Feb 2003 11:32:35 -0500
Date: Tue, 25 Feb 2003 08:38:11 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: vherva@twilight.cs.hut.fi, mikael.starvik@axis.com,
       linux-kernel@vger.kernel.org, tinglett@vnet.ibm.com,
       torvalds@transmeta.com
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-Id: <20030225083811.797fbce6.rddunlap@osdl.org>
In-Reply-To: <20030225113557.C9257@flint.arm.linux.org.uk>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se>
	<20030225092520.A9257@flint.arm.linux.org.uk>
	<20030225110704.GD159052@niksula.cs.hut.fi>
	<20030225113557.C9257@flint.arm.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003 11:35:57 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

| On Tue, Feb 25, 2003 at 01:07:04PM +0200, Ville Herva wrote:
| > On Tue, Feb 25, 2003 at 09:25:20AM +0000, you [Russell King] wrote:
| > > Agreed - zImage is already around 1MB on many ARM machines, and since
| > > loading zImage over a serial port using xmodem takes long enough
| > > already, this is one silly feature I'll definitely keep out of the
| > > ARM tree.
| > 
| > Why not make it a config option (like the other (two? three?) rejected
| > patches that implemented this did)?
| 
| I, for one, do not see any point in trying to put more and more crap
| into one file, when its perfectly easy to just use the "cp" command
| to produce the same end result, namely a copy of zImage, System.map
| and configuration, thusly:
| 
| cp arch/$ARCH/boot/zImage /boot/vmlinuz-$VERSION
| cp .config /boot/config-$VERSION
| cp System.map /boot/System.map-$VERSION

Yes, that almost matches my 'new.kernel' install script.

| No hastles with configuration options.  No hastles with bloated zImage
| files.  No hastles with adding extra stuff to makefiles to do special
| mangling to zImage.

Yes, you wouldn't have to use it.

| If people are worried about vmlinuz being out of step with config, once
| you add the above to the installation target of the kernel makefile,
| unless you do things manually, you won't get out of step.
| 
| If you're worried about config-* and System.map-* being out of step with
| the kernel you're running, exactly the same applies to the "everything
| in one file" version as well.
| 
| If you need to make a backup of it:
| 
| mkdir /boot/old
| cp /boot/*-$VERSION /boot/old
| 
| Nice.  Simple.  No crap.

I'm just guessing that it will be difficult to convince you otherwise,
but I think you are missing the point of this.  It's not for someone
who already has scripts to handle this or already uses 3+ commands
to handle it every time that they build a new kernel.  It's for
people who are less organized than you are -- gosh, maybe even
for Linux users.

--
~Randy

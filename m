Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268914AbTBZUft>; Wed, 26 Feb 2003 15:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268921AbTBZUft>; Wed, 26 Feb 2003 15:35:49 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:21224 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268914AbTBZUfs>; Wed, 26 Feb 2003 15:35:48 -0500
Message-ID: <3E5D2787.9020209@vnet.ibm.com>
Date: Wed, 26 Feb 2003 14:45:59 -0600
From: Peter Bergner <bergner@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Todd Inglett <tinglett@vnet.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: zImage now holds vmlinux, System.map and config in sections.
 (fwd)
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se>	<20030225092520.A9257@flint.arm.linux.org.uk>	<20030225110704.GD159052@niksula.cs.hut.fi>	<20030225113557.C9257@flint.arm.linux.org.uk>	<20030225083811.797fbce6.rddunlap@osdl.org> 	<20030225175204.B21014@flint.arm.linux.org.uk> <1046289675.21297.11.camel@q.rchland.ibm.com>
In-Reply-To: <1046289675.21297.11.camel@q.rchland.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todd Inglett wrote:
> These sections don't have to be thrown away after boot either.  While
> the sections should be marked as no-load, it may be useful to actually
> load them and have the kernel explicitly toss them if it finds no use
> for them.  Real uses would including exporting to /proc/config.gz (if
> you like that kind of thing), or providing the System.map to kdb if kdb
> is enabled.

To be precise, these sections _are_ part of a PT_LOAD segment in the
zImage bootloader.  The kernel/vmlinux is then passed info via birecs
on where those sections are in memory.  As you say, we can then decide
in the kernel whether we want to keep or toss them.

Peter



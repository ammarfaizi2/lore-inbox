Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbTBZSb1>; Wed, 26 Feb 2003 13:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268859AbTBZSb1>; Wed, 26 Feb 2003 13:31:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:5561 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268856AbTBZSbZ>;
	Wed, 26 Feb 2003 13:31:25 -0500
Message-ID: <3E5D0A4B.1090502@vnet.ibm.com>
Date: Wed, 26 Feb 2003 12:41:15 -0600
From: Peter Bergner <bergner@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Jackson <jerj@coplanar.net>, Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: zImage now holds vmlinux, System.map and config in sections.
 (fwd)
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk> <20030225110704.GD159052@niksula.cs.hut.fi> <20030225113557.C9257@flint.arm.linux.org.uk> <20030225120357.GC158866@niksula.cs.hut.fi> <002f01c2dcda$ff505070$7c07a8c0@kennet.coplanar.net>
In-Reply-To: <002f01c2dcda$ff505070$7c07a8c0@kennet.coplanar.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:
 > From a pure technical point of view, it seems just like bloat.  But from a
 > distribution, maintenance, etc point of view, it's a godsend.  It's a config
 > option, just like devfs and initrd, so just don't use it if you don't want
 > to.

It was precisely for those reasons I made the changes (Todd Inglett was nice
enough to push the changes for me, hence his name on the change set).  The PPC64
arch is a server platform, so the extra disk space caused by the bloat in the
zImage isn't a problem.  However, the benefits of having the attached sections
is a godsend when a customer calls you up with a kernel problem and all they
can give you (they may not be very adept with Linux) is the zImage and some
type of error message.


Russell King wrote:
 > So you want to transfer the complete zImage, including the redundant
 > configuration and system.map to the target over the network, only to
 > have it thrown away?

For our architecture, why not?  We're not short on disk space and we can
netboot, so no problems there.  Yeah, for ARM and other embedded arches,
it may not be what you want to do, but for PPC64, it's a good solution.



Peter



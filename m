Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSLLLxF>; Thu, 12 Dec 2002 06:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSLLLxF>; Thu, 12 Dec 2002 06:53:05 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:36293
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262708AbSLLLxE>; Thu, 12 Dec 2002 06:53:04 -0500
Subject: Re: 2.5.51 ide module problem (fwd)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Chua <jchua@fedex.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021212094909.67D3D2C0F7@lists.samba.org>
References: <20021212094909.67D3D2C0F7@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 12:38:27 +0000
Message-Id: <1039696707.21192.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 09:48, Rusty Russell wrote:
> And you will continue to.  There really is a loop, which means neither
> module can be loaded (ide_dump_status is in ide.ko, and ide-io.ko wants
> it, however ide.ko uses lots of things in ide-io.ko).  However, this
> patch will stop depmod from crashing.
> 
> Ask the IDE people,

The module changes basically left me unable to do any further 2.5.5x
work at an acceptable rate. My time is now allocated to other projects
until January. At that point hopefully the module stuff will be usable
again, parameters will work etc and I can go back to work on 2.5.

Rusty is right that the ide stuff has dependancy loops right now. His
new module stuff shouldn't have crashed but the fundamental work to be
done is in the IDE layer. There are also some locking problems to
address before modular IDE becomes useful.

Alan


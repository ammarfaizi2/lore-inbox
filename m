Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbTCEXbC>; Wed, 5 Mar 2003 18:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbTCEXbC>; Wed, 5 Mar 2003 18:31:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58020
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266968AbTCEXbC> convert rfc822-to-8bit; Wed, 5 Mar 2003 18:31:02 -0500
Subject: Re: Top stack (l)users
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030305202157.GA392@wohnheim.fh-wedel.de>
References: <20030305202157.GA392@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1046911594.15950.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 00:46:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-05 at 20:21, Jörn Engel wrote:
> arch = i386
> make allyesconfig
> <remove everything that breaks>
> make checkstack
> 
> Quite interesting. ide_unregister moved down to rank 4.
> Bronce goes to drivers/cdrom/optcd.c (does anyone still use it?).
> Silver is drivers/message/i2o/i2o_proc.c.

i2o_proc is just a dump stack object -> kmalloc. Its probably ok
because its not in any deep call nests but like a few of the others
might make a fun little janitor project.

ide_unregister I'm working on. Its easy to do a hack fix, but I want
to do the full interface death and retry stuff 


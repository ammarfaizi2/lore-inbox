Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbTBZV6B>; Wed, 26 Feb 2003 16:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268973AbTBZV6B>; Wed, 26 Feb 2003 16:58:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36491
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268971AbTBZV57>; Wed, 26 Feb 2003 16:57:59 -0500
Subject: RE: [PATCH] ide write barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "LEE,SCOTT  " "(HP-Roseville,ex1)" <scott_lee@hp.com>
Cc: "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <6BD67FFB937FD411A04F00D0B74FE8780790C607@xrose06.rose.hp.com>
References: <6BD67FFB937FD411A04F00D0B74FE8780790C607@xrose06.rose.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046301011.10600.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 26 Feb 2003 23:10:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 21:20, LEE,SCOTT (HP-Roseville,ex1) wrote:
> If the cached writes can be reordered then of course it stands that caching
> would be unsafe.  Does anyone know if IDE drives do this?  I'm certainly no
> expert in this area but I thought only SCSI drives reordered operations.

Undefined. There certainly seem to be drives whose physical sector size
exceeds the one it presents to the world. Modern disk is all smoke and
mirrors for compatibility hack on top of compatibility hack.

I can't find anything in the spec that requires drives do not. Nor can
I find anything in the spec requiring a drive implements the cache flush
as anything except a nop [I believe ATA6 changed that for the very
newest stuff]. Not all drives appear to honour any kind of cache disable
either.


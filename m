Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSIZPCq>; Thu, 26 Sep 2002 11:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbSIZPCq>; Thu, 26 Sep 2002 11:02:46 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:19961
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261356AbSIZPCo>; Thu, 26 Sep 2002 11:02:44 -0400
Subject: Re: [PATCH] fix ide-iops for big endian archs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20020925224428.5676@192.168.4.1>
References: <Pine.LNX.4.33.0209251120590.1817-100000@penguin.transmeta.com>
	 <20020925224428.5676@192.168.4.1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 16:11:51 +0100
Message-Id: <1033053111.1269.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-25 at 23:44, Benjamin Herrenschmidt wrote:
> properly on BE, further cleanup of the iops is pending, I'm waiting
> for Alan own experiments before I push again my own that remove
> all "p" iops and all of the {IN,OUT}{BYTE,WORD,LONG} macros.

Thats true in current -ac. I killed the _p crap. Nobody uses it, the
switching for handling it is bogus anyway. If anyone has such broken
code they can implement ide-iops-speak-slowly-after-the-tone.c



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSHLJMd>; Mon, 12 Aug 2002 05:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSHLJMd>; Mon, 12 Aug 2002 05:12:33 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:27640 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317639AbSHLJMc>; Mon, 12 Aug 2002 05:12:32 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Padraig Brady <padraig.brady@corvil.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D57782E.5090009@corvil.com>
References: <Pine.LNX.4.33.0208091459010.1283-100000@penguin.transmeta.com>
	 <3D57782E.5090009@corvil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 11:37:47 +0100
Message-Id: <1029148667.16424.144.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 09:56, Padraig Brady wrote:
> Anyone care to clarify which filesystems don't
> have unique inode numbers. I always thought you
> could uniquely identify any file using a device,inode
> tuple? Fair enough proc is "special" but can/should
> you not assume unique inodes within all other filesystems?

2.4 functions correctly here in all the stuff I've looked at. I can't
speak for 2.5. In the 2.4 case you must be holding the files open during
the comparison. Some file systems like MSDOS invent inodes as they go,
never issuing the same one to two objects at the same time but happily
reissuing different inode numbers the next time around.

That breaks NFS but not much else



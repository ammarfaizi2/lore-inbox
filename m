Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUCKMXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 07:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUCKMXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 07:23:55 -0500
Received: from amazone.ujf-grenoble.fr ([193.54.238.254]:59076 "EHLO
	amazone.ujf-grenoble.fr") by vger.kernel.org with ESMTP
	id S261220AbUCKMXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 07:23:52 -0500
From: Mickael Marchand <marchand@kde.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm1
Date: Thu, 11 Mar 2004 13:23:38 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <20040310233140.3ce99610.akpm@osdl.org> <200403111017.33363.marchand@kde.org> <20040311030607.22706063.akpm@osdl.org>
In-Reply-To: <20040311030607.22706063.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403111323.39014.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
> > while I am at it, I am running a 64 bits kernel with 32 bits debian
> > testing and it seems some ioctl conversion fails
> > that happened with all 2.6 I tried.
> > here is the relevant kernel messages part :
> > ioctl32(dmsetup:26199): Unknown cmd fd(3) cmd(c134fd00){01} arg(0804c0b0)
> > on /dev/mapper/control
>
> The device mapper version 1 ioctl interface was removed.  Perhaps you need
> to update your dm tools?
the debian tools are built with ioctlv4 (and compat for v1)
I also tried with my own compiled dm tools from source without success

> > ioctl32(fsck.reiserfs:201): Unknown cmd fd(4) cmd(80081272){00}
> > arg(ffffdab8) on /dev/ide/host0/bus0/target0/lun0/part4
>
> Is this something which 2.6 has always done, or is it new behaviour?
always since 2.6 IIRC

> reiserfs ioctl translation appears to be incomplete...
ha :)

thanks,
Mik

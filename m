Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262383AbSJKKXg>; Fri, 11 Oct 2002 06:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbSJKKXg>; Fri, 11 Oct 2002 06:23:36 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:27824 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262383AbSJKKXd>; Fri, 11 Oct 2002 06:23:33 -0400
Subject: Re: [PATCH] [RFC] Advanced TCA Disk Hotswap support in Linux Kernel
	[core 1/2]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Dake <scd@broked.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <004401c270c4$4bbe2a50$0200000a@persist>
References: <004401c270c4$4bbe2a50$0200000a@persist>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Oct 2002 11:40:21 +0100
Message-Id: <1034332821.7042.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-11 at 02:19, Steven Dake wrote:
> This mechanism is far superior to /proc/scsi/scsi because it:
> 1) provides true FibreChannel hotswap support (at this point qlogic FC
> HBAs)
> 2) is programmatic such that errors can be reported from kernel to user
>    without looking is /var/log/.
> 3) Provides superior response times vs opening a file and writing to
> proc.
> 4) Easier to control from kernel and user via C APIs vs using
> open/write.

Doesn't seem to have any locking/ Thats a scsi layer problem that does
need tackling to mke hotswap actually work well. At the very least the
host queue needs locks and probably the hosts need refcounting now



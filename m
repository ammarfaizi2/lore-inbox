Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265034AbSJWO6v>; Wed, 23 Oct 2002 10:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265036AbSJWO6v>; Wed, 23 Oct 2002 10:58:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18566 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265034AbSJWO6t>; Wed, 23 Oct 2002 10:58:49 -0400
Date: Wed, 23 Oct 2002 11:06:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: EISA AIC7XXX not detected
In-Reply-To: <200210231448.g9NEmJp04017@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.3.95.1021023105914.13301B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Denis Vlasenko wrote:

> Hi,
> 
> I have an oldie Pentium 66 box which was running OS/2
> for a very long time. Probably the last OS/2 box in our town :)
> 
> I want to convert it into backup web server.
> 
> The problem is that it does not see its disks when I boot Linux.
> Currently I'm running it in NFS root mode, but 16MB RAM is not
> much fun without swap :(
> 
> I'd like to stick printks here and there in driver source,
> thought you may have some advice.
> 
> In particular, is this relevant?
> "kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2"
> --

Yes. You need to load aic7xxx.o, the SCSI driver. in /etc/modules.conf
you need:

alias scsi_hostadapter scsi_mod
alias scsi_hostadapter sd_mod
alias scsi_hostadapter aic7xxx

alias block-major-8 sd_mod
alias block-major-11 sr_mod
alias char-major-9 st


That should get your SCSI stuff running including tape and CDROM.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America



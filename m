Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbRF1TE0>; Thu, 28 Jun 2001 15:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263894AbRF1TEH>; Thu, 28 Jun 2001 15:04:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39809 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263814AbRF1TEA>;
	Thu, 28 Jun 2001 15:04:00 -0400
Date: Thu, 28 Jun 2001 15:03:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Gerhard Wichert <Gerhard.Wichert@fujitsu-siemens.com>
Subject: Re: [PATCH] Bug in 2.4.5 in proc_pid_make_inode ()
In-Reply-To: <Pine.LNX.4.30.0106281619150.17260-100000@biker.pdb.fsc.net>
Message-ID: <Pine.GSO.4.21.0106281501550.23792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jun 2001, Martin Wilck wrote:

> Hi,
> 
> I have recently experienced a number of kernel OOPSes
> in "top" under heavy load. Kernel is 2.4.5 (IA64, but
> this has nothing to do the IA64 patch).
> 
> The OOPS happens in the call tree
> 
> open () system call
> [...]
> real_lookup ()
> proc_base_lookup ()
> proc_pid_make_inode ()
> iput ()
> proc_delete_inode () -> OOPS in __MOD_DEC_USE_COUNT

Known, had been already fixed in 2.4.6-pre3.


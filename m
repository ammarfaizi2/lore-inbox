Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSJJUTs>; Thu, 10 Oct 2002 16:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263825AbSJJUOI>; Thu, 10 Oct 2002 16:14:08 -0400
Received: from dp.samba.org ([66.70.73.150]:58816 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263327AbSJJUIj>;
	Thu, 10 Oct 2002 16:08:39 -0400
Date: Thu, 10 Oct 2002 20:14:22 +0000
From: jra@dp.samba.org
To: Steven French <sfrench@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, jra@samba.org
Subject: Re: [BK PATCH] CIFS filesystem for Linux 2.5
Message-ID: <20021010201422.C3579@dp.samba.org>
References: <OFFB04937F.1EAC8996-ON87256C4E.006DA4CF@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFFB04937F.1EAC8996-ON87256C4E.006DA4CF@boulder.ibm.com>; from sfrench@us.ibm.com on Thu, Oct 10, 2002 at 03:08:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 03:08:53PM -0500, Steven French wrote:
> The CIFS filesystem has been updated to handle yesterday's changes to the
> superblock structure and has been added to a new bitkeeper repository as a
> single bitkeeper changset in order to be easier to apply.  It is changeset
> number 1.747 at bk://cifs.bkbits.net/linux-2.5-with-cifs  and is low risk,
> not changing core kernel files.
>
> ...... stuff cut......
> 
> The CIFS file system is ready to be included in the 2.5 Linux kernel and
> only affects the usual small set of files outside its own directory
> (fs/cifs) that a filesystem must change (e.g. fs/Config.in, fs/Makefile,
> fs/Config.help) but does not require changes to any core kernel code.
> 
> The filesystem is designed for remote access to Samba, newer Windows
> servers and also the many common CIFS based NAS appliances, but unlike
> smbfs is optimized for the current version of the SMB/CIFS protocol.   The
> CIFS file system can coexist with smbfs.   The CIFS file system is
> reasonably stable, passing most but not all of the standard filesystem test
> suites going to either Windows servers or Samba (NB a few Samba bug which I
> am working is blocking fsx at the moment and memory mapping support is not
> finished) running with the current 2.5 kernel.  It has been tested at both
> Connectathon and the CIFS Plugfest this year and has been under development
> for over a year with the assistance from some others on the Samba team as
> well as feedback from the standards group (SNIA CIFS Technical Workgroup)
> and others at IBM.    The project web site has more information on the
> project http://us1.samba.org/samba/Linux_CIFS_client.html

I don't know if it will help, but here's my 2 cents (US :-). I'd love
this to be included into 2.5.x Linux, as it is a very nicely written,
modern CIFS client that we can use to start adding UNIX specific extensions
into Samba, and hopefully end up with a filesystem that uses UNIX semantics
when talking to a Samba server, and will fall back to Windows semantics
when talking to lagacy Windows server (I really love saying that :-) :-).

Should be a big help in making Linux the "universal client glue" we know
and love .... :-).

Cheers,

	Jeremy Allison,
	Samba Team.

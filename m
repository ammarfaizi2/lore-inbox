Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSATX0C>; Sun, 20 Jan 2002 18:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSATXZw>; Sun, 20 Jan 2002 18:25:52 -0500
Received: from mons.uio.no ([129.240.130.14]:32755 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S288967AbSATXZq>;
	Sun, 20 Jan 2002 18:25:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15435.20982.84353.824971@charged.uio.no>
Date: Mon, 21 Jan 2002 00:25:42 +0100
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] with 2.4.18-pre4+linux-2.4.18-NFS_ALL
In-Reply-To: <20020120222722.3972B143F@shrek.lisa.de>
In-Reply-To: <20020120164118.D587513E3@shrek.lisa.de>
	<shsbsfo6gt9.fsf@charged.uio.no>
	<20020120222722.3972B143F@shrek.lisa.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:

     > On Sunday, 20. January 2002 19:03, Trond Myklebust wrote:
    >> >>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:
    >> > Hi Trond et al., I can reliably reproduce this oops on my
    >> > diskless with NFS_ALL applied, but not with plain-pre4, just
    >> > by quitting one of {StarOffice,VMware}.
    >>
    >> The new version should be rid of it. It was a call to
    >> get_file() which was missing a test for a NULL argument.

     > Are you sure?

I forgot the nfs_cred_file() in the line above. That too is fixed now,
and so fsx is running fine again...

Cheers,
   Trond

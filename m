Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUATUbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUATUbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:31:53 -0500
Received: from c217236.adsl.hansenet.de ([213.39.217.236]:35475 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S265732AbUATUbv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:31:51 -0500
Message-ID: <400D902D.8080607@portrix.net>
Date: Tue, 20 Jan 2004 21:31:41 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jlnance@unity.ncsu.edu
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       cmp@synopsys.com
Subject: Re: Awful NFS performance with attached test program
References: <20040119211649.GA20200@ncsu.edu> <1074549226.1560.59.camel@nidelv.trondhjem.org> <20040120132803.GA2830@ncsu.edu>
In-Reply-To: <20040120132803.GA2830@ncsu.edu>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E1D811E9BCC8C031D9B8386"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E1D811E9BCC8C031D9B8386
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

jlnance@unity.ncsu.edu wrote:
> On Mon, Jan 19, 2004 at 04:53:46PM -0500, Trond Myklebust wrote:
> 
> 
>>So you are surprised that writing the same dataset by putting one
>>integer onto each kernel page takes much more time than placing the
>>entire dataset onto just a few kernel pages? 'cos I'm not...
> 
> 
> I must admit that I am.  I could see that it would take somewhat longer
> because a logicial way for the kernel to implement this would be as a
> read-modify-write operation.  So a 2X slowdown would not supprise me.
> But the slowdown is more than 10X, and that does.
> 
> Also, for what its worth, Solaris performs like this:
> 
>     flame> ./a.out 
>     Creating file: 3.886 seconds
>     Updating file: 1.259 seconds
> 
> While Linux performs like this:
> 
>     jesse> ./a.out
>     Creating file: 43.042 seconds
>     Updating file: 555.796 seconds

My Client (2.6.1-mm2) against my server (2.6.1-bk6) is significantly faster:

./nfstest
Creating file: 11.607 seconds
Updating file: 35.885 seconds

Note the increase of the factor 3 only instead of 10.
nfs mount options: 
rw,hard,intr,rsize=8192,wsize=8192,timeo=30,retrans=10,tcp

Thanks,

Jan

--------------enig4E1D811E9BCC8C031D9B8386
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFADZAtLqMJRclVKIYRAkEQAJ40PjZdQaiEk5R2vgCK7MNpK67EzQCgjjjt
hB60i2qkE2pwiMxKvfWMjJo=
=Nnks
-----END PGP SIGNATURE-----

--------------enig4E1D811E9BCC8C031D9B8386--

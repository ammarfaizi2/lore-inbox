Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVF0Gby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVF0Gby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVF0Gbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:31:52 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:62473 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261851AbVF0G1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:27:34 -0400
Message-ID: <42BF9C4D.3080800@slaphack.com>
Date: Mon, 27 Jun 2005 01:27:25 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <200506270423.j5R4Np9n004510@turing-police.cc.vt.edu> <42BF8F42.7030308@slaphack.com> <200506270541.j5R5fULX007282@turing-police.cc.vt.edu>            <42BF9562.4090602@slaphack.com> <200506270612.j5R6CZGX008462@turing-police.cc.vt.edu>
In-Reply-To: <200506270612.j5R6CZGX008462@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 27 Jun 2005 00:57:54 CDT, David Masover said:
> 
> 
>>In one of three possible settings for the imaginary zipfile plugin, yes.
>> But if we're talking about a kernel source tree, how many of us
>>actually build zipfiles/tarballs of their kernel source trees, rather
>>than unpack existing ones?
> 
> 
> I dunno.  I'll often build a tarball of "-mm plus local patches" known to
> be working at the moment, precisely so I can just untar that as a known good
> base for the next kernel-hackfest, rather than untar Linus's tree, apply all
> of the -mm patch, then all my local patches again...

What you really want is a copy-on-write tree, or a simpe cp.  Or are you
that short on space that you need compression?

Speaking of which, I know copy-on-write files are planned.  What about
whole trees?

But, short of that, you can always do a poor man's copy-on-write with
"cp -al" or "cp -as", assuming you remember to copy when you write...

> And even if I'm not *that* ambitious, I'll at least tar up a clean -mm tree
> to use as a base. :)

I just keep a -mm patch around and the original vanilla tarball, but to
each his own.

> And even if I didn't do that, you *do* have to do something when the disk
> gets backed up.  You *do* intend for sensible things to happen then, right? ;)

I back up with rsync, actually.

Speaking of backup, that's another nice place for a plugin.  Imagine a
dump that didn't have to be of the entire FS, but rather an arbitrary
tree...  That might be a nice new archive format.  I know Apple already
uses something like this for their dmg packages.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr+cTXgHNmZLgCUhAQIvvxAAk70+cz4yOZaMX6TDIuUWNsPjqM890FMa
jpNE5I2K3ZV91yJFAMdSZW1fQSQakorJyt0DV6wnxu3EbIZV8ATeIkNgJsqcDxAD
O6dZoIQnFZND90Fh3HdJb46DRZyml4NbeEKhQRzIAnuANIAa4+6it2aERcpbDNxE
ijOiVVpjTkUEutI2uuCJTYSXOGDa+rI0Jmth/9VnPAb5r+wqUb49wUziaSslnZs5
Jt6UlIcXU/OymzhWe+9JM0gydP+V2nP4N14oYoiXaqINPCA9OHV7BudClkKDeCyv
bYXyRfjmuiDNoOel6ZfURqUFR2GK/dPqI1PBV6Vc4UMsUqIKkGLAuQ5rU0csb39f
eS+6Dp8DJ7tOvQp73x1KTMJWP0lha1VRAj8s3SwdCp0Xar8YHymfCDjHvx/iJe50
rY5aZfWXGCzVmbKVETE8ACWeF5bgpnzwMDwU2RlaWhV/1yIZSOttuJFWMHNG4Rns
ajUrRsV9cmmngIJBMcM6XaZD9eRsJ9gb+E9POpsFbo6OwhS0IpRlzu/AGGoEiHSW
ZGNBoSDuLDluHP1jiXrnM7ONcFPEe2opUD7ltgSkYPKpya9C7lEfsEBzXh5Gqc5X
Iw8P0Md7U6rjCJYGb0pwnJQa0MYMimXq3hOTVsLdoj4A1Nn0EVntHzpB/QTe4UX2
NjMlwpPIXkU=
=fqm7
-----END PGP SIGNATURE-----

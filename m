Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVGLWOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVGLWOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVGLWOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:14:53 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:18442 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262401AbVGLWOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:14:45 -0400
Message-ID: <42D44EA9.7030700@slaphack.com>
Date: Tue, 12 Jul 2005 18:13:45 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, Hans Reiser <reiser@namesys.com>,
       Hubert Chan <hubert@uhoreg.ca>, Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<878y0svj1h.fsf@evinrude.uhoreg.ca>	<42C4F97B.1080803@slaphack.com>	<87ll4lynky.fsf@evinrude.uhoreg.ca>	<42CB0328.3070706@namesys.com>	<42CB07EB.4000605@slaphack.com>	<42CB0ED7.8070501@namesys.com>	<42CB1128.6000000@slaphack.com>	<42CB1C20.3030204@namesys.com>	<42CB22A6.40306@namesys.com>	<42CBE426.9080106@slaphack.com>	<42D1F06C.9010905@stesmi.com>	<42D2DB99.9050307@slaphack.com> <17107.28428.30907.184223@cse.unsw.edu.au>
In-Reply-To: <17107.28428.30907.184223@cse.unsw.edu.au>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Neil Brown wrote:
> On Monday July 11, ninja@slaphack.com wrote:
> 
>>Stefan Smietanowski wrote:
>>
>>>-----BEGIN PGP SIGNED MESSAGE-----
>>>Hash: SHA1
>>>
>>>
>>>
>>>>Ok, still haven't heard much discussion of metafs vs file-as-directory,
>>>>but it seems like it'd be easier in metafs.
>>>
>>>
>>>Why not implement it inside the directory containg the file ?
>>>
>>>Ie the metadata for /home/stesmi/foo is in /home/stesmi/.meta/foo
>>>
>>>This should be suit both camps I'd think?
>>
>>You still need to figure out the parent of "foo", which isn't 
>>necessarily easy, especially considering that even if we store a link to 
>>the parent, it will be inside the metadata.  Then you have a 
>>chicken-and-egg situation.
>>
>>Both camps seem to want to allow easy access to the metadata of a file, 
>>whether we're given that file as an inode or as a pathname.  That's why 
>>I suggested /meta/vfs and /meta/inode -- sometimes I want to look up a 
>>file by name, and sometimes by inode, but either way, I should be able 
>>to get its metadata.
> 
> 
> Well, it's not really 'as an inode or as a pathname'.  It is 'as an
> open file descriptor or as a path name' which is an important
> difference.
> 
> Maybe it is worth repeating Al Viro's suggestion at this point.  I
> don't have a reference but the idea was basically that if you open
> "/foo" and get filedescriptor N, then
>    /proc/self/fds/N-meta

How am I supposed to get there with a shell script?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQtROqXgHNmZLgCUhAQLRcg/+I9PWSmFXRwKtj7pnEeMXOCjiTo6GQE3O
61fjH3f6aL9Ydkip4eXum3S14cioiU9bzC11GA5kRIM+W1DKcYex1dIpivrtF9Ht
Rvozn9x2TP5tacDmSfqRJXvAB+xTRtZOu+M/rDjXdLsriDJDA0AdyDH8Yo/8WMbU
6i1DWzLTO0vHS3kEb/8oqgBj7sQ63sS/4KVszBx6+bN0KOikXbORDu6efKjC9w21
3DZPnBG0B03smhdCygd0j0Zmh0JEaZHfuFgNK1ZmRzipbvvUBDtdKY5MJ6f4pHnA
GBO8ybsXp9qxNQr6DNenF/wbAT6n3dMyE/AWuql+qx3iumSwx/Prh7xDAhBZBMXp
Oin7hOa1i583cdju4ErSBPaciRzumGluY6gbFvVA8Yva+IjPxxjPtfLwalK11cH1
k4oQO5Par1W0TmMOpc0PQ/bEeEHHxUcn1ToeJa4NYJWIiBe+UHMb/AyI4hKjSIkt
Kp0wrCPBjRfuBCHXXL89bWZoSeSFkN8fAyOxBV928naxxr8e+vCPUX1/H3ca7UsB
Nxg0Vzt4V9tz4xCw4QAy810Uya8/HSm3aVhqEzjHKBoKboHrMVDJvxRQxfkqQcnC
4jIFYPBdHgGw7OONyhfbgTPLIm1OCNPpcRkS4aidHqg0DkDU50h6zFQkhG5Xwh5Z
x5REgxbqD+A=
=FGm4
-----END PGP SIGNATURE-----

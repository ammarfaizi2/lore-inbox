Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbULQQDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbULQQDH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbULQQDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:03:07 -0500
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:20408 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S261415AbULQQCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:02:47 -0500
Message-ID: <41C30325.4040604@slaphack.com>
Date: Fri, 17 Dec 2004 10:02:45 -0600
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>	 <41ACA7C9.1070001@namesys.com>	 <1103043518.21728.159.camel@pear.st-and.ac.uk>	 <41BF21BC.1020809@namesys.com>	 <1103059622.2999.17.camel@grape.st-and.ac.uk>	 <41BFC1C5.1070302@slaphack.com> <1103102854.30601.12.camel@pear.st-and.ac.uk> <41C0CF3B.1030705@slaphack.com> <41C1D870.2020407@namesys.com>
In-Reply-To: <41C1D870.2020407@namesys.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
| David Masover wrote:
|
|>
|>
|> Speaking of which, how much speed is lost by starting up a process?
|>
|> The idea of caching is that running
|>
|> cat *; cat *; cat *; cat *; cat *
|>
|> is probably slower than
|>
|> cat * > baz; cat baz; cat baz; cat baz; cat baz; cat baz
|
|
| Only for small files where the per file overhead of a read is significant.

That's potentially a common problem, and "cat *" is an overly-simplified
example.  Either you force the "plugin" to say whether it wants to be
cached or not, or you cache everything, because there are going to be
plugins like "tar -xjp" for which caching is a HUGE increase.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQcMDJHgHNmZLgCUhAQLDMxAAiW6qcBUDKepjkGGK30yyjpia7yzbRlI5
CLSwLnRFTX+oVoqIjYgjw6Cy+Y+kPAW8nL54Vnrvn/fjd05YV6SXIql/XqX5ZY1M
SXSD9LKnhxUEIH80Qcm8MdKtx0CrAPSIxVehpz7Clrv8pSClgtN2JIG1r4FsQHuB
E3Hasw11bHKZmg+NgYtNn1IDcgUxz2iTmw8xSwAlPtBZz8Enc4so4VVqZPOUYg+z
CTYOi84Qe8ecDGjhC6ZNvuEKsd8PgNl81MgEcJ5zcsnyCbNLpS2E8v1drsfVmXE5
8kbwelpc2q5ayEnNjeJgpIug8wH57cRWyc5KlAY733kZFTloG3LsnlWli8j9v0LT
sTcOtJMWa2zj7O7LE+1z/j6xMkjlPoT/QolMsAUv0SqloOihsfF3R71uolW3mrvM
VT8eQw5VUSHZyix/MqU0uDdvbOXsAoRvDL4xhdUAQv9/WbpGCNsB1PAiM693GFT2
A3VKiEcp0KMRUQZUxa5E1tBZh7WpwFvYkNTqxoN1fIDRKR6o/snAUDVb8UdTWxaW
T169coH6jS/4gEQVzsZ2PvWJ8gGpV5BjXM0C/04pgVLN4e610sJsoUXsha49wpob
bXgA8kw1wHp2C9fuA/NjNzyki8kzaTunkviu8ki/kaV7fEirVc0Prw78w7G2MkcC
j3enAzaZHVI=
=UFkt
-----END PGP SIGNATURE-----

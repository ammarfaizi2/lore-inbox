Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVFZJgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVFZJgU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 05:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVFZJgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 05:36:20 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:4115 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261214AbVFZJfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 05:35:19 -0400
Message-ID: <42BE76D5.8050608@slaphack.com>
Date: Sun, 26 Jun 2005 04:35:17 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
Cc: Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Valdis.Kletnieks@vt.edu, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>	 <42BCD93B.7030608@slaphack.com>	 <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>	 <42BDA377.6070303@slaphack.com>	 <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>	 <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <42BE66C2.3000509@cisco.com>
In-Reply-To: <42BE66C2.3000509@cisco.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lincoln Dale wrote:
> 
> 
> David Masover wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Lincoln Dale wrote:
>>
>> [...]
>>
>>  
>>
>>> this is the WHOLE point of standardization .. i don't think its that
>>> Reiser4's EAs offer any more or less capabilities than standard EAs -
>>>   
>>
>>
>> They do.  Reiser4's EAs can look like any other object -- files,
>> folders, symlinks, whatever.  This is important, especially for
>> transparency.
>>  
>>
> it was accepted not so long ago that 'file-as-directory' and 'EA' are
> two different things, predominantly because existing tools and apps
> won't necessarily "do the right thing<tm>".

They are different, but not quite -- what's the word -- discrete?
Rather, file-as-directory is one logical conclusion of EA, and one
possible representation of EA.

Anyway, Reiser's EAs currently (I think) could appear as files, but not
necessarily the file-as-directory madness we were talking about then.
They could also be accessed by openat.  And they can also be
hierarchical, which I would think makes them cleaner and faster.

> this has been discussed to death previously.  oh what a surprise. 
> http://lwn.net/Articles/100271/

I was there.  That was fun to watch, actually, once it got over my head.

The three points he lists are only relevent if you try to do
file-as-directory.  Right now, I like the idea of file attributes as
showing up in separate magic directories, or just creating magic
directories first and filling them with files.  Symlinks could help
clean up messiness, and allow you to do things like encrypt /etc/passwd
- -- symlink to /etc/crypto/passwd/decrypted or something.  Yes, I know
about shadow, and there are still some paranoid reasons to encrypt passwd.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr521XgHNmZLgCUhAQKSSA/9HK8JiG6wW40jQDUXsyKPz+l9UvoaNuLs
hqIXo3sdQj1CWAuwa1BKY16w91tJBN3uX75jLgwR36ix4A1jXQ5v1sRjvfkLKR/7
3a51v9UsRAhAisiqWFGWYTrbXgAh+S5B51xHuXv3qTs/wqC8sxuJtAHwuCldPaBr
cR1WzPtGvgd+ESqx5avllZIfNCy9tcH3P5fUsaIFCCm30E6u9PVO6xBOHylFWZKS
Pywv+wGUTxbgCFSmLG07/zhwVF94fAHPIWXQXQGmhPrGf3Wtt7VTMiRpkpyONyso
eoY1hFiwyh2YMrIPxdL0Uo+mcDvErWFFZyTcCGqIMp6x+QSe0Ww9Ie90afZPvvS0
Q4DmdST2JEHEinal5MCiqr3S83wanv3+h9ywTCEkTcl3mEK1iwtc4dwmvRNVHfkx
f34CAxM1rBfu++kd3xgL+Kb/ao4LOCDhVL3XY6pNDglX6Y+Kk5dRSJjOm4kAU2fB
j66uGOUZOiCCzSMLvVrCAPnNXmUavLKUXDKXKL2gTCYM6TL+7RkAXEMrqu5YxdZM
ihIbfmGc7FzItbQCDZhhozG51IMkLCotU9U9CaotnhfUaosibmwEnmeY8FWY75ba
MOs+VH3UJUZObRBwmBHSX4pwg5sDhSjyqPR05M26A5xz8nGh4kukD/E6QZYCB9EP
lVdDus4iJUM=
=hsOJ
-----END PGP SIGNATURE-----

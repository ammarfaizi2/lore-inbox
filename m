Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbTBKSnE>; Tue, 11 Feb 2003 13:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbTBKSnE>; Tue, 11 Feb 2003 13:43:04 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:65300 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264886AbTBKSnC>;
	Tue, 11 Feb 2003 13:43:02 -0500
Message-ID: <3E494681.6090200@acm.org>
Date: Tue, 11 Feb 2003 12:52:49 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mauricio Martinez <mauricio@coe.neu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 drivers/cdrom/cdu31a.c
References: <Pine.GSO.4.33.0302111235510.29078-100000@Amps.coe.neu.edu>
In-Reply-To: <Pine.GSO.4.33.0302111235510.29078-100000@Amps.coe.neu.edu>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mauricio Martinez wrote:

|Thanks for your reply. I guess there are still some drives like this
|floating around. I can live without it, but it is good to use it in an old
|486 as a jukebox and print server :)
|
|Your patch makes much more sense that mine (I have no experience in Linux
|driver development), and it makes the drive work *very well* (excellent
|transfer rate and no system overload), but only if I remove the last hunk.
|
|This last hunk tries to read again the data with 4 sectors less each time
|(i.e. 16,14,12,...,4) which *i think* overloads the buffer leading to an
|oops (and even a system reboot without warning!).
|
|Hope this information helps.

That's really wierd.  Can you make the code in question be:
~            } else if (nblock > 0) {
~                printk("Number of blocks left: %d\n", nblock);
~                end_request(1);
~            } else {

and then send the results when it happens?

It turns out my machine does not have an ISA bus slot, so I can't plug 
my drive in anywhere.

Thanks,

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+SUaAIXnXXONXERcRAurxAKCgATRBLbNDprxCKcKdsmrPuVkQggCdEwFX
ZVMPef8C10TZzcjEbIgz09U=
=RF+b
-----END PGP SIGNATURE-----



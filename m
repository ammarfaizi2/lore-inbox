Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTD1O0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 10:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbTD1O0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 10:26:32 -0400
Received: from h80ad24b9.async.vt.edu ([128.173.36.185]:52352 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261161AbTD1O0a (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 10:26:30 -0400
Message-Id: <200304281438.h3SEcFdA003667@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: Andreas Schwab <schwab@suse.de>, Mark Grosberg <mark@nolab.conman.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall. 
In-Reply-To: Your message of "Mon, 28 Apr 2003 10:16:21 EDT."
             <Pine.LNX.4.53.0304281001200.16752@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org> <Pine.LNX.4.53.0304280855240.16444@chaos> <jed6j67o4o.fsf@sykes.suse.de> <Pine.LNX.4.53.0304280951500.16637@chaos> <jeadea7mj3.fsf@sykes.suse.de>
            <Pine.LNX.4.53.0304281001200.16752@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1467049834P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Apr 2003 10:38:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1467049834P
Content-Type: text/plain; charset=us-ascii

On Mon, 28 Apr 2003 10:16:21 EDT, "Richard B. Johnson" said:

> Read the bash documentation `man bash`. The first argument becomes
> $0 (the process name), the second becomes $1, etc. Please  don't
> just keep assuming that I don't know what I'm talking about.
> 
> $ sh -c 'ignore echo a b c'
> Works fine.

[~]2 /bin/bash -c ignore echo a b c
echo: line 1: ignore: command not found
[~]2 /bin/bash -c 'ignore echo a b c'
/bin/bash: line 1: ignore: command not found

Obviously, tokenization makes a difference here. ;)

So let's try forcing $0 to /bin/bash rather than 'ignore'...

[~]2 sh -c '/bin/bash echo a b c'
echo: /bin/echo: cannot execute binary file

Correct, but unexpected results..

[~]2 sh -c /bin/echo echo a b c

[~]2 sh -c '/bin/echo a b c'
a b c

Again, tokenization matters - try working out what the value of argc is
for the exec of /bin/bash for each of these cases...

Dick, do you have an 'ignore' in your $PATH?


--==_Exmh_-1467049834P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+rTzWcC3lWbTT17ARAv2BAJ4o+c3b+HuL3iew1texOep99wq5fACgt1t1
4kSfc6aWdBo8HdZ3NY0i4lI=
=Jmbh
-----END PGP SIGNATURE-----

--==_Exmh_-1467049834P--

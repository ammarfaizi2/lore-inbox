Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTEaSX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTEaSX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:23:26 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:5385 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264394AbTEaSXZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 14:23:25 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: pdflush -> noflushd related question
Date: Sat, 31 May 2003 20:36:55 +0200
User-Agent: KMail/1.5.2
References: <200305311841.59599.fsdeveloper@yahoo.de> <20030531105850.7cc92601.akpm@digeo.com>
In-Reply-To: <20030531105850.7cc92601.akpm@digeo.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305312036.55506.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 31 May 2003 19:58, Andrew Morton wrote:
> You can turn these guys off by setting the sysctls to 1000000000
> I guess.   Problem is, I don't think there's a way of starting them
> again until the ten million seconds expires.  hmm.

I've thought a little bit more about it.
Why do you think, there is no way of waking up?
Is it, because, when I set it to 1000000000 and the back to,
let's say, 500, the pdflush threads don't wake up to recognize
this change? Is this the cause?

What about signaling all pdflush threads with, for example,
for(ALL_PDFLUSHS)
	kill(pid, SIGSTOP);

Don't they wake up then and recognize the reducing of the timeout?
The old noflushd did so to wake up updated.

thanks.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 20:32:32 up  6:04,  2 users,  load average: 2.05, 2.03, 2.00

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+2PZHoxoigfggmSgRAjx2AJ9orNNk8SLQlhBg+lJ1ZsyGgOb/9ACgjBjW
bm0WPZwvb8Rd0bGti2XFBOQ=
=Et8g
-----END PGP SIGNATURE-----


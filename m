Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265750AbUFDMEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUFDMEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbUFDMEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:04:44 -0400
Received: from sendar.prophecy.lu ([213.166.63.242]:16530 "EHLO
	sendar.prophecy.lu") by vger.kernel.org with ESMTP id S265755AbUFDMEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:04:38 -0400
Message-ID: <40C06549.2030200@linux.lu>
Date: Fri, 04 Jun 2004 14:04:25 +0200
From: Thierry Coutelier <Thierry.Coutelier@linux.lu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, fr-lu, de-lu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Freeze with 2.4.x
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Propehcy.lu-MailScanner-Information: Please contact the ISP for more information
X-Propehcy.lu-MailScanner: Found to be clean
X-Propehcy.lu-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greeting,

We are using Linux boxes to offer Satellite Internet. We still use RedHat 7.[23]
The system works using rp-l2tp and/or pptpd with pppd. On the outgoing interface (the
one that sends traffic to the Satellite we were using CBQ and now we use HTB queuing
discipline.

The kernels range from 2.4.6 to 2.4.25 with some modifications (tcp_input). We tried
with the standard kernel with the only change that the dev_alloc_name has been
changed to support up to 900 names.

Every few weeks (sometimes 2 days, often 3 weeks and sometime up to 9 weeks) the
kernel freezes: nothing on screen or serial console except from some VJ decompression
errors which we have at all times, even the Num-Lock does not respond.
We tried to enable sysreq keys but those won't work either.

2 days ago we were able to catch the following message (12 hours before a freeze) :
HTB: dequeue bug (8,12140714,12140714), report it please !


The Hardware are Dell PowerEdge with Perc2 or Perc3. We tried with HP servers and
have the same problem. We tried different firmware releases for the Perc cards and
still no change.

The NIC cards are mostly Intel EEpro 100. We tried with both drivers Intel and
community with no better results.

The problem may be happening more often (every 2/3 days) when we simulate a lot of
ppp connections/disconnections (80 users/minute), but in some cases it hangs even
without having many users.

The platform we run have between 25 to 200 simultaneous connections. Some have single
or dual or even quad CPU's. And RAM between 512Mbytes and 4 Gbytes.

We could not detect any parameters that would rise before the freeze (load, memory,
swap ...)

Could anyone give me some hint as to what to do/test more ?
Where could the problem be ?


Thanks.

- --
Thierry Coutelier
No Patents on Software: http://www.linux.lu/epatent

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAwGVJPOfrcNNQX7oRAm9tAKCKXcW/htHDLJgjLKCIjPJbEK4yNwCguJe2
auyEN1rBK7DZNgZ3iSkD524=
=oveM
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTFBOMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTFBOMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:12:09 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:49414 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262352AbTFBOMG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:12:06 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: maneesh@in.ibm.com
Subject: Re: [2.5.70] possible problem with /dev/diskstats
Date: Mon, 2 Jun 2003 16:19:32 +0200
User-Agent: KMail/1.5.2
References: <200306010035.58957.fsdeveloper@yahoo.de> <20030602051030.GB1256@in.ibm.com>
In-Reply-To: <20030602051030.GB1256@in.ibm.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306021619.43005.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 02 June 2003 07:10, Maneesh Soni wrote:
> On Sat, May 31, 2003 at 10:40:21PM +0000, Michael Buesch wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hi.
> >
> > I've just played around with my server (that has actualy no load)
> > and I recognized something strange in /dev/diskstats.
> >
> > Documentation/iostats.txt says about diskstats:
> > [SNIP]
> > Field  9 -- # of I/Os currently in progress
> >     The only field that should go to zero. Incremented as requests are
> >     given to appropriate request_queue_t and decremented as they finish.
> > [SNIP]
> >
> > But here is a cat /proc/diskstats:
> >    1    0 ram0 0 0 0 0 0 0 0 0 0 0 0
> >    1    1 ram1 0 0 0 0 0 0 0 0 0 0 0
> >    1    2 ram2 0 0 0 0 0 0 0 0 0 0 0
> >    1    3 ram3 0 0 0 0 0 0 0 0 0 0 0
> >    1    4 ram4 0 0 0 0 0 0 0 0 0 0 0
> >    1    5 ram5 0 0 0 0 0 0 0 0 0 0 0
> >    1    6 ram6 0 0 0 0 0 0 0 0 0 0 0
> >    1    7 ram7 0 0 0 0 0 0 0 0 0 0 0
> >    1    8 ram8 0 0 0 0 0 0 0 0 0 0 0
> >    1    9 ram9 0 0 0 0 0 0 0 0 0 0 0
> >    1   10 ram10 0 0 0 0 0 0 0 0 0 0 0
> >    1   11 ram11 0 0 0 0 0 0 0 0 0 0 0
> >    1   12 ram12 0 0 0 0 0 0 0 0 0 0 0
> >    1   13 ram13 0 0 0 0 0 0 0 0 0 0 0
> >    1   14 ram14 0 0 0 0 0 0 0 0 0 0 0
> >    1   15 ram15 0 0 0 0 0 0 0 0 0 0 0
>
> Rick,
>
> ramdisk stats are also always zero whether you do any IO or not. Any idea
> where this can be corrected.

Hmm, yes, I've had /var on ram0 in this example, but it doesn't show
any statistics for it.

> Thanks
> Maneesh

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 16:17:13 up 20 min,  1 user,  load average: 1.00, 0.97, 0.74

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+21z+oxoigfggmSgRAvqPAJ9ZXw2Rrk1FZQovWUu58xQlNEareACeLVoo
ZVw22gyiSz3ehXdtxaK+LlM=
=Rw7M
-----END PGP SIGNATURE-----



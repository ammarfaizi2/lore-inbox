Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130993AbQL1QWT>; Thu, 28 Dec 2000 11:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131038AbQL1QWJ>; Thu, 28 Dec 2000 11:22:09 -0500
Received: from hermes.mixx.net ([212.84.196.2]:32772 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130993AbQL1QWH>;
	Thu, 28 Dec 2000 11:22:07 -0500
Message-ID: <3A4B60FA.FD05ED4C@innominate.de>
Date: Thu, 28 Dec 2000 16:49:14 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <3A4A505A.3CF8A8BB@innominate.de> <18670000.977950159@coffee>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Wednesday, December 27, 2000 21:26:02 +0100 Daniel Phillips
> <phillips@innominate.de> wrote:
> 
> > Hi Chris.  I took your patch for a test drive under dbench and it seems
> > impressively stable under load, but there are performance problems.
> >
> >        Test machine: 64 meg, 500 Mhz K6, IDE, Ext2, Blocksize=4K
> >        Without patch: 9.5 MB/sec, 11 min 6 secs
> >        With patch: 3.12 MB/sec, 33 min 51 sec
> >
> 
> Cool, thanks for the testing.  Which benchmark are you using?  bonnie and
> dbench don't show any changes on my scsi disks, I'll give IDE a try as well.

Chris, this was an error, I had accidently booted the wrong kernel.  The
'With patch' results above are for 2.2.16, not your patch.

With correct results you are looking much better:

      Test machine: 64 meg, 500 Mhz K6, IDE, Ext2, Blocksize=4K
      Test: dbench 48

      pre13 without patch:	9.5 MB/sec 	11 min 6 secs
      pre13 with patch:		8.9 MB/sec 	11 min 46 secs
      2.2.16:			3.1 MB/sec 	33 min 51 sec

This benchmark doesn't seem to suffer a lot from noise, so the 7%
slowdown with your patch likely real.

We've come a long way from 2.2.16, haven't we?  I'll run some of these
tests against 2.2 pre19 kernels and maybe fan the flames of the 2.2/2.4
competition a little.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136279AbRARXcS>; Thu, 18 Jan 2001 18:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136313AbRARXcI>; Thu, 18 Jan 2001 18:32:08 -0500
Received: from [202.123.212.187] ([202.123.212.187]:18443 "EHLO ns1.b2s.com")
	by vger.kernel.org with ESMTP id <S136279AbRARXcB>;
	Thu, 18 Jan 2001 18:32:01 -0500
Message-ID: <3A677CFA.DE6F7D93@vtc.edu.hk>
Date: Fri, 19 Jan 2001 07:32:10 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: rsync + ssh fail on raid; okay on 2.2.x
In-Reply-To: <Pine.LNX.4.10.10101181225030.7200-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

> > Kernel: 2.4.0, no patches
>
> use 2.4.1-pre8.  much better VM tuning.

Thank you Mark, I will try that.

> > PIII 450MHz, 256MB RAM, Acus P3B-F motherboard (Intel 440BX)
> > Mail going to Raid 1 device
> > The file Inbox is only 2.9MB
> > OS = Red Hat 7 with all updates, both home and work.
> > Same with ppp 2.3.x and ppp 2.4.0
> > Same whether work machine runs 2.2.16 or 2.4.0 kernel.
>
> any swap?

Yes, 400MB swap, only a small fraction of it used; vmstat 5 looks okay
and shows no understandable reason for the error message.  Here are a
few lines from vmstat: the point at which free memory jumps up is just
after the "Write failed: Cannot allocate memory" message:

 2  0  0   9276   1792   8952 110388   0   0   378     0 2400   295  11  26  63

 2  0  0   9276   1760   8952 110420   0   0     0     0  492   319   6   2  92

 3  0  0   9276   1596   8952 110588   0   0    96     0  754   326   8   5  87

 2  1  0   9276   1620   8828 110692   0   0   751   207 5378   275  19  74   7

 1  0  0   9276  26680   8828  91760   0   0   115     0 1094   307   9  11  80

 2  0  0   9276  26680   8828  91760   0   0     0     0  120   318   4   1  95

I have many hundreds of MB or GB of disk space in the various
partititions.  I will try the newer kernel, though I am interested in
understanding what's going on here too.

--
Nick Urbanik, Dept. of Computing and Mathematics
Hong Kong Institute of Vocational Education (Tsing Yi)
email: nicku@vtc.edu.hk
Tel:   (852) 2436 8576, (852) 2436 8579   Fax: (852) 2435 1406
pgp ID: 7529555D fingerprint: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

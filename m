Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTFIMIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 08:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTFIMIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 08:08:22 -0400
Received: from camus.xss.co.at ([194.152.162.19]:58374 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S264190AbTFIMIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 08:08:19 -0400
Message-ID: <3EE47BE4.8020000@xss.co.at>
Date: Mon, 09 Jun 2003 14:21:56 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc7] AP1700-S5 system freeze :-((
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>	<3EDF3310.7040501@xss.co.at>	<3EE208F1.4000008@xss.co.at>	<3EE45E94.7070209@xss.co.at> <20030609134606.094d55ae.skraw@ithnet.com>
In-Reply-To: <20030609134606.094d55ae.skraw@ithnet.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Many thanks for your reply!

Stephan von Krawczynski wrote:
> Hello Andreas,
>
> I am not quite sure if you are experiencing something similar to my problem.
> Fact is this:
>
> I have a serverworks based dual PIII board and I am experiencing freezes just
> about every day.
>
> Equal setups:
>
> Kernel 2.4.21-rc7
> 00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (me: rev 23 you: rev 31)
> 00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
>
> Lockups during light load
>
Me too.
I had it running for 24 hours with heavy stress testing
and a load above 7 all the time without problems. I then
stopped this test, and the box locked up 2 hours later,
and locked up about 7 or 8 times in the past few days :-(

>
> Differing:
>
> Just about everything else:
>                        yours:            mine:
> Storage System:        Symbios           AIC

This is not a "normal" symbios logic "sym53c8xx"
storage controller, but a "Symbios Logic 53c1030",
which uses the Fusion MPT driver. This is the first
time I'm running this driver, so I don't know if it's
considered stable (but I guess so)
Unfortunately I can't replace it as I don't have any
spare SCSI controller which fits right now.

> VGA           :        ATI Rage XL       ATI Radeon RV200
> Network       :        Intel/3com        Intel/Broadcom
> Processor     :        Xeon UP           PIII SMP
>
>
> I could already produce oops-messages on the problem and mine all come up in
> kmem_cache_alloc_batch. It would be interesting where your box freezes. It
> cannot be at this same place, because the code is not there in UP.
> Try this (in case you are not working in front of the box):
>
> Start box and switch to text console, enter "setterm -blank 0" to disable
> screen blanker. Wait for oops. If we are lucky you will see something, get a
> pencil then :-)
>
I always have the system running with text console and
screen blanking disabled. Alas, I see no oops :-(

IMHO it doesn't look like the kernel crashes with an oops,
it does look more like it suddenly goes into an endless
loop or ridiculously high load somehow.
Last time I hade this freeze, I noticed that the system
answered my ICMP ping messages with a delay of more than
60 seconds. This looked like the system was very busy
at that time.

I'm now running with 2.4.20rc2, and also have syslog
routed to another system on the network. We'll see if
I can get any more information out of this.

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+5HvjxJmyeGcXPhERAvOvAJ94cQS4tlzylHiVU084v7FK/e/aowCgw4w9
M3YWSHXzx9IuKeU4Z6WicEk=
=8102
-----END PGP SIGNATURE-----


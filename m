Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUKCIHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUKCIHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 03:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbUKCIHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 03:07:42 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:28428 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261468AbUKCIH2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 03:07:28 -0500
Date: Wed, 3 Nov 2004 09:01:48 +0100 (CET)
To: jthiessen@penguincomputing.com, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: adm1026 driver port for kernel 2.6.X - [REVISED DRIVER]
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <NN38qQl1.1099468908.1237810.khali@gcu.info>
In-Reply-To: <20041102221745.GB18020@penguincomputing.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Justin,

> > Granted it's not part of the standard yet, but you would have three
> > files temp[1-3]_crit_enable if we stick to our chip-indenpendent
> > interface logic. Either make 1 read-write and [2-3] read-only, or make
> > all read-write and each one changes the three values.
>
> Any reason not to simply provide 3 sysfs files pointing at the same
> variable/register bit?  Maintaining separate variables for a single,
> uncomplicated value seems rather overkill.

That's pretty much what I was proposing, actually ;) I never meant three
different variables. The discussion was about having all files
read-write or not. I usually have only the first file read-write and
others read-only mirrors thereof, but sometimes people don't like that
arbitrary symmetry breakage and go for read-write mirrors. You choose.

> (...)
> I would agree that it is a bit confusing that there are essentially 2
> temperature-motivated mechanisms for forcing fan speeds to full (automatic
> PWM fan control, and critical temperature monitoring), but I think that the
> utility of providing a critical temperature fail-safe is worth the
> minor amount of confusion.

Agreed.

> No problem.  Sorry that it's taking so much revision to get the kinks
> worked out.  This will undoubtedly become less trouble as I get more
> familiar with i2c/lm_sensors/kernel issues.

Well, the adm1026 driver is a complex driver which never received testing
and reviewing so far, because it is so rarely found on motherboards.
It's perfectly normal that it takes a couple revisions and discussion
to get it in good shape. Thanks for the good work so far.

--
Jean Delvare

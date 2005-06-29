Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVF2IIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVF2IIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 04:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVF2IIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 04:08:34 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:64270 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262481AbVF2IIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 04:08:19 -0400
Date: Wed, 29 Jun 2005 10:08:35 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, tytso@mit.edu,
       zwane@arm.linux.org.uk, jmforbes@linuxtx.org, rdunlap@xenotime.net,
       torvalds@osdl.org, chuckw@quantumlinux.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, andrew.vasquez@qlogic.com,
       James.Bottomley@SteelEye.com
Subject: Re: [02/07] [SCSI] qla2xxx: Pull-down scsi-host-addition to follow
 board initialization.
Message-Id: <20050629100835.60dc42f8.khali@linux-fr.org>
In-Reply-To: <20050628152037.690c3840.akpm@osdl.org>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
	<20050627225349.GK9046@shell0.pdx.osdl.net>
	<20050628235148.4512d046.khali@linux-fr.org>
	<20050628152037.690c3840.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> If the person who originally raised that patch put unrelated things
> into a single patch then that's where the problem started.

Agreed.

> Bear in mind that there is also risk in only part-applying a patch.

If applying only a part of a given patch doesn't sound safe, then I
would question the supposed obvious correctness of this patch in the
first place.

Some times ago, Alan stated he liked -stable because "its small enough
that most of the add on patches people use aren't breaking against it"
[1]. I found this a sound statement, but if we now accept non-minimum
changes, this won't be true any longer (or at least this will tend to
become less true).

> > This aint -stable material.
> 
> But it's obviously safe.  Let's use our brains on these patches and
> not become beholden to doctrine, OK?

Why did we write down and discuss rules for -stable in the first place
then [2]? Of the 9 rules Greg first listed as conditions for a patch to
be accepted in -stable, this patch breaks 4 (it is bigger than 100
lines, if fixes more than one thing, including one that doesn't bother
people as far as I can see, and it has trivial fixes in it.) So I don't
think I am actually splitting hair as you seemed to suggest. I know some
of these rules were slightly reworded afterwards, but still.

I reviewed the latest stable series of patches with these rules in mind,
trying to help. If the rules have since changed - and it seems they did,
then instead of helping, I have been wasting your time, and mine. Where
were the new rules discussed? We better have a web page summarizing the
current rules for -stable if we want submitters and reviewers to do the
right thing.

Thanks.

[1] http://kerneltraffic.org/kernel-traffic/kt20050612_315.html#5
[2] http://kerneltraffic.org/kernel-traffic/kt20050403_303.html#9

-- 
Jean Delvare

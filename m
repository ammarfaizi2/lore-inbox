Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268729AbUIAGRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268729AbUIAGRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 02:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268985AbUIAGRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 02:17:18 -0400
Received: from [203.200.212.145] ([203.200.212.145]:25744 "EHLO
	atcmail.atc.tcs.co.in") by vger.kernel.org with ESMTP
	id S268729AbUIAGRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 02:17:15 -0400
From: prasad@atc.tcs.co.in
Message-ID: <36886.203.200.212.145.1094019402.squirrel@203.200.212.145>
In-Reply-To: <Pine.LNX.4.61.0409010549230.32036@student.dei.uc.pt>
References: <1094008341.4704.32.camel@wizej.agilysys.com>
    <41355005.6030204@atc.tcs.co.in>
    <Pine.LNX.4.61.0409010549230.32036@student.dei.uc.pt>
Date: Wed, 1 Sep 2004 11:46:42 +0530 (IST)
Subject: Re: Kernel or Grub bug.
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: "Wise, Jeremey" <jeremey.wise@agilysys.com>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-1
X-Mailer: SquirrelMail/1.4.3a-1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


have you tried removing the initrd entry in GRUB.
In most cases you can safely do away with it.  That would
atleast make sure the problem is not with the initrd.

Prasad

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Wed, 1 Sep 2004, Prasad wrote:
>
>>> "Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)"
>>
>> Your partition table suggests that there are two different partitions
>> for
>> '/boot'
>> and '/'.  The GRUB loads the kernel from '/boot' which is (hd0,0) but
>> the
>> kernel is unable to find the '/' partition.   You may pass it using the
>> parameter
>> root=/dev/hda3.
>>
>> That should work.
>>
>> Prasad
>
> It may not work. As he said in the original message, he found lot's of
> other
> people with that problem, including... myself. Since 2.6.4 I can't boot
> any 2.6
> kernel, allways with that Kernel panic. I've tried several things,
> including
> using the root=/dev/hda3 parameter, and, at the time, I've raised the
> issue
> here on LKML, but no conclusion has been reached.
>
> A search on LKML led me to this:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0403.3/1180.html
>
> Mind Booster Noori
>
> - --
> /* *************************************************************** */
>     Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
>     http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
>     () Join the ASCII ribbon campaign against html email, Microsoft
>     /\ attachments and Software patents.   They endanger the World.
>     Sign a petition against patents:  http://petition.eurolinux.org
> /* *************************************************************** */
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> Comment: Made with pgp4pine 1.76
>
> iD8DBQFBNWTnmNlq8m+oD34RAm5CAJ9ZCFWJySRz3RRFCPUtcRhueFbcvgCeJAoo
> SxqGk3ho9GdPptdsFmV/N8E=
> =xyRu
> -----END PGP SIGNATURE-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


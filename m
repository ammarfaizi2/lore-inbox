Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUIAG4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUIAG4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 02:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268832AbUIAG4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 02:56:20 -0400
Received: from smtp.dei.uc.pt ([193.137.203.228]:49070 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S266353AbUIAG4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 02:56:16 -0400
Date: Wed, 1 Sep 2004 07:55:02 +0100 (WEST)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: prasad@atc.tcs.co.in
cc: "Wise, Jeremey" <jeremey.wise@agilysys.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel or Grub bug.
In-Reply-To: <36886.203.200.212.145.1094019402.squirrel@203.200.212.145>
Message-ID: <Pine.LNX.4.61.0409010752260.32036@student.dei.uc.pt>
References: <1094008341.4704.32.camel@wizej.agilysys.com>   
 <41355005.6030204@atc.tcs.co.in>    <Pine.LNX.4.61.0409010549230.32036@student.dei.uc.pt>
 <36886.203.200.212.145.1094019402.squirrel@203.200.212.145>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 1 Sep 2004 prasad@atc.tcs.co.in wrote:

> have you tried removing the initrd entry in GRUB.
> In most cases you can safely do away with it.  That would
> atleast make sure the problem is not with the initrd.

Yes, I did it.
I'm actually using lilo, but I've tried with both.

Mind Booster Noori

> Prasad
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On Wed, 1 Sep 2004, Prasad wrote:
>>
>>>> "Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)"
>>>
>>> Your partition table suggests that there are two different partitions
>>> for
>>> '/boot'
>>> and '/'.  The GRUB loads the kernel from '/boot' which is (hd0,0) but
>>> the
>>> kernel is unable to find the '/' partition.   You may pass it using the
>>> parameter
>>> root=/dev/hda3.
>>>
>>> That should work.
>>>
>>> Prasad
>>
>> It may not work. As he said in the original message, he found lot's of
>> other
>> people with that problem, including... myself. Since 2.6.4 I can't boot
>> any 2.6
>> kernel, allways with that Kernel panic. I've tried several things,
>> including
>> using the root=/dev/hda3 parameter, and, at the time, I've raised the
>> issue
>> here on LKML, but no conclusion has been reached.
>>
>> A search on LKML led me to this:
>> http://www.ussg.iu.edu/hypermail/linux/kernel/0403.3/1180.html
>>
>> Mind Booster Noori
>>
>> - --
>> /* *************************************************************** */
>>     Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
>>     http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
>>     () Join the ASCII ribbon campaign against html email, Microsoft
>>     /\ attachments and Software patents.   They endanger the World.
>>     Sign a petition against patents:  http://petition.eurolinux.org
>> /* *************************************************************** */
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.2.1 (GNU/Linux)
>> Comment: Made with pgp4pine 1.76
>>
>> iD8DBQFBNWTnmNlq8m+oD34RAm5CAJ9ZCFWJySRz3RRFCPUtcRhueFbcvgCeJAoo
>> SxqGk3ho9GdPptdsFmV/N8E=
>> =xyRu
>> -----END PGP SIGNATURE-----
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFBNXJzmNlq8m+oD34RAh2pAKCvzDOV4fUcvqBic+acnLO7SmCQmQCdEasr
wemYv6ZwmAW+AKQuOYCN290=
=VahV
-----END PGP SIGNATURE-----


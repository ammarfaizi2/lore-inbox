Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266398AbUBLMsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 07:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266403AbUBLMsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 07:48:04 -0500
Received: from CPE-65-28-18-238.kc.rr.com ([65.28.18.238]:8350 "EHLO
	mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S266398AbUBLMrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 07:47:48 -0500
Message-ID: <50365.192.168.1.12.1076590069.squirrel@mail.2thebatcave.com>
In-Reply-To: <Pine.LNX.4.58.0402120457250.28596@student.dei.uc.pt>
References: <46246.192.168.1.12.1076553774.squirrel@mail.2thebatcave.com>
    <Pine.LNX.4.58.0402120457250.28596@student.dei.uc.pt>
Date: Thu, 12 Feb 2004 06:47:49 -0600 (CST)
Subject: Re: /proc/partitions not done updating when init is ran?
From: "Nick Bartos" <spam99@2thebatcave.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, it is 2.4.25-pre7.  I could technically go to 2.6.x, but it would take
a bit of work due to some other changes.  I would really like to get this
stable in 2.4.x.

What is nbd?


> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> Is that happening in 2.6.2-rc3-mm1 or up?
>
> If yes, try unsetting nbd in your kernel config.
>
> Mind Booster Noori
>
> - --
> ==================================================
> Marcos Daniel Marado Torres AKA Mind Booster Noori
> /"\               http://student.dei.uc.pt/~marado
> \ /                       marado@student.dei.uc.pt
>  X   ASCII Ribbon Campaign
> / \  against HTML e-mail and Micro$oft attachments
> ==================================================
>
> On Wed, 11 Feb 2004, Nick Bartos wrote:
>
>> I have a problem where it does not look like /proc/partitions is updated
>> completely by the time init is ran.
>>
>> Basically I am booting from a usb flash device, and when I try to run
>> fsck
>> on the device on boot (using LABEL=, which is necessary since the actual
>> device cannot be assumed in my config) it fails.  After further
>> investigation /proc/partitions does not contain any scsi partitions
>> right
>> when init is starting, but if I do a "sleep 10" before running fsck then
>> it works fine.
>>
>> I can of course put that sleep in there but that is ugly and I have no
>> way
>> of knowing the maximum delay, so if it took too long then it would not
>> work and I would be screwed...
>>
>> Isn't /proc/partitions supposted to be finished updating when init
>> starts?
>>  If this is not a kernel bug (or it won't be fixed for a while), then
>> what
>> is the deal and how can I fix this cleanly?
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> Comment: Made with pgp4pine 1.76
>
> iD8DBQFAKwf2mNlq8m+oD34RAvICAJ94Kv1Yspu0syE8MLAZwSHEgJ8i4ACdEOJy
> KqWcNxWT9t3o1jm1gUq04Ew=
> =u2Ds
> -----END PGP SIGNATURE-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


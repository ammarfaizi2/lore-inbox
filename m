Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWCVOnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWCVOnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 09:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWCVOnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 09:43:47 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:20761 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751261AbWCVOnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 09:43:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=OY9DCHAKRpul1MSXpHY73WE1GXfNLLD54BSYRMuJFfdtrhaWIEcEUXezTrMTdk3HUp0s6SA5FjONAr+L4wdc0bcdcnniutNGmQh7duewVZTezMUYOFEvUfrEKAGKLm/Kh8SJwcV9x15Rv6QuC0wWtG+9AlExBY6NKt6Ec9Erspk=
Message-ID: <44216384.4070709@gmail.com>
Date: Wed, 22 Mar 2006 21:47:32 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: stefano.melchior@openlabs.it
CC: user-mode-linux-user@lists.sourceforge.net,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Cannot debug UML
References: <44215200.8020708@gmail.com> <20060322135015.GC8115@SteX> <44215B8F.6060400@gmail.com> <20060322142820.GF8115@SteX>
In-Reply-To: <20060322142820.GF8115@SteX>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefano Melchior wrote:
> On Wed, Mar 22, 2006 at 09:13:35PM +0700, Mikado wrote:
> Hi Mikado,
>>> same problem as mine:
>>> ./linux mode=tt debug ubd0=root_fs ubd1=swap mem=128MB eth0=tuntap,,,192.168.0.254
>>>
>>> You wrongly used "mem" option!
>> I've checked my UML's memory, it's exactly 128MB. But thank you, I will
>> follow UML rules.
> 
> what I meant is that you need to follow what man page states: with the
> "mem" option you need to follow the amount of memory (32, 64, 128, ...)
> with only "m" or "M", not "MB".
> Then in some cases it fails when you use mem=128M instead of mem=128m, for
> instance.
> First try without the "mem" option in the command line to see if it works;
> then try with  mem=128M and if it doesn't work, with  mem=128m.
> 
> Otherwise a patch it is needed :(
> 
> Cheers
> 
> SteX

I've tried below cases and the same problem is still there.

./linux mode=tt debug ubd0=root_fs ubd1=swap eth0=tuntap,,,192.168.0.254
./linux mode=tt debug ubd0=root_fs ubd1=swap mem=128m
eth0=tuntap,,,192.168.0.254
./linux mode=tt debug ubd0=root_fs ubd1=swap mem=128M
eth0=tuntap,,,192.168.0.254
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEIWOENWc9T2Wr2JcRAm0GAJ0TD0KOWpUuxOek6nFvGGYcDWvoTACeKFLX
k3B36hpIDLXZ1t/qQFgZ0eo=
=FcYY
-----END PGP SIGNATURE-----

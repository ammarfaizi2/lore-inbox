Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275252AbTHGJfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275253AbTHGJfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:35:45 -0400
Received: from camus.xss.co.at ([194.152.162.19]:49677 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S275252AbTHGJfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:35:36 -0400
Message-ID: <3F321D41.1090004@xss.co.at>
Date: Thu, 07 Aug 2003 11:34:57 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: herbert@13thfloor.at
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Rene Mayrhofer <rene.mayrhofer@gibraltar.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jason Baron <jbaron@redhat.com>
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
References: <3F309FD8.8090105@gibraltar.at> <Pine.LNX.4.44.0308061633240.2722-100000@logos.cnet> <20030806195101.GB16054@www.13thfloor.at>
In-Reply-To: <20030806195101.GB16054@www.13thfloor.at>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Herbert Pötzl wrote:
> On Wed, Aug 06, 2003 at 04:33:52PM -0300, Marcelo Tosatti wrote:
>
>>What is your problem with pivot_root?
>>
>>Sorry but I've searched the list archives and found nothing but this email
>>and this patch, which seems a bit hackish.
>
>
>  Jul 21  Rene Mayrhofer     82 pivot_root seems to be broken in 2.4.21-a1716
>  Jul 22  Denis Vlasenko    103   >
>  Jul 22  Rene Mayrhofer     54     >
>  Jul 22  Jason Baron        18       >
>  Jul 22  Alan Cox           22         >
>  Jul 22  Rene Mayrhofer     25           >
>  Jul 22  Alan Cox           17             >
>  Jul 22  Rene Mayrhofer    154               >
>  Jul 23  Mika Penttilä      40               >
>  Jul 22  Mika Penttilä      41           >
>
This patch also solves my problem as reported on Jul. 29th
(Subject: "2.4.22-pre4: devfs on initrd stays busy after pivot_root"
Message-ID: 3F267FD7.4040400@xss.co.at) and in more detail
on July 30th, (Message-ID: 3F2795DE.5020306@xss.co.at)

I just tried it with 2.4.22-rc1, and with this patch I am
able to umount /initrd/dev and /initrd after pivot_root
again!

Don't know yet if it has any ill side effects, though.

HTH

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/Mh0/xJmyeGcXPhERAmbLAKCUrXFUA44ggJvOBMlwvA4GKFsWdwCeNIid
4bWSyQ2OFqwXnNdU8t/bJsw=
=sdiS
-----END PGP SIGNATURE-----


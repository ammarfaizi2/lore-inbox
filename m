Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130143AbRCBXhc>; Fri, 2 Mar 2001 18:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130145AbRCBXhW>; Fri, 2 Mar 2001 18:37:22 -0500
Received: from anubis.han.de ([212.63.63.3]:6149 "EHLO anubis.han.de")
	by vger.kernel.org with ESMTP id <S130143AbRCBXhK>;
	Fri, 2 Mar 2001 18:37:10 -0500
Date: Sat, 3 Mar 2001 00:41:14 +0100
From: jum@anubis.han.de (Jens-Uwe Mager)
Message-Id: <slrn9a0bjn.o1.jum@anubis.han.de>
Newsgroups: hannet.ml.linux.rutgers.linux-kernel
Subject: Re: ftruncate not extending files?
In-Reply-To: <mng==Pine.LNX.4.30.0103011502050.23650-100000@swamp.bayern.net> <E14YXft-0008GK-00@the-village.bc.nu> <20010302084544.A26070@home.ds9a.nl> <mng==20010302095701.A4685@sable.ox.ac.uk>
Organization: At Home
Apparently-To: <jum@anubis.han.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au

On Fri, 2 Mar 2001 10:17:14 GMT, Malcolm Beattie <mbeattie@sable.ox.ac.uk> wrote:
>bert hubert writes:
>> I would've sworn, based on the fact that I saw people do it, that ftruncate
>> was a legitimate way to extend a file
>
>Well it's not SuSv2 standards compliant:
>
>    http://www.opengroup.org/onlinepubs/007908799/xsh/ftruncate.html
>
>    If the file previously was larger than length, the extra data is
>    discarded. If it was previously shorter than length, it is
>    unspecified whether the file is changed or its size increased. If
>    ^^^^^^^^^^^
>    the file is extended, the extended area appears as if it were
>    zero-filled.
>
>How "legitimate" relates to "SuSv2 standards compliant" is your call.

It is interesting to compare the wording of the Solaris man page, it
sounds pretty much like the SuSv2 paragraph above, but without the
restriction that the result is unspecified, it guarantees the extending
is a legitimate operation. Sounds like the SuSv2 authors chickened out
on that issue, most of the Unix platforms I know (including SunOS 4&5,
HP/UX, IRIX, Tru64, AIX and various *BSD) do happily extend a file on
truncate.

-- 
Jens-Uwe Mager	<pgp-mailto:62CFDB25>


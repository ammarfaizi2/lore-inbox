Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267071AbSLDUaV>; Wed, 4 Dec 2002 15:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267072AbSLDUaV>; Wed, 4 Dec 2002 15:30:21 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:11781 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S267071AbSLDUaU>; Wed, 4 Dec 2002 15:30:20 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: #! incompatible -- binfmt_script.c broken?
In-Reply-To: <20021204183710.GA4004@merlin.emma.line.org>
References: <20021204113419.GA20282@merlin.emma.line.org> <20021204142628.GE26745@riesen-pc.gr05.synopsys.com> <20021204142628.GE26745@riesen-pc.gr05.synopsys.com> <20021204183710.GA4004@merlin.emma.line.org>
Message-Id: <E18JgHI-0006Gx-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Date: Wed, 04 Dec 2002 20:37:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andre wrote:
>On Wed, 04 Dec 2002, Alex Riesen wrote:
>> The interpreter (/bin/sh) has got everything after
>> its name. IOW: "-- # -*- perl -*- -T"
>
>Yes, as SINGLE argument. Therefore, Perl programs break if they use this
>procedure recommended by "man perlrun".
>
>I don't care WHY it works everywhere else, I want this incompatibility
>fixed and I'm not going through a flame war as with the 4.4BSD
>SIOCGIFNETMASK issue again. This is not negotiable.

See http://www.uni-ulm.de/~s_smasch/various/shebang/ . FreeBSD is the
*only* OS to pass multiple arguments. SUS says nothing about it, and
pretty much every single implementation varies. It does not work
everywhere else.

>We have enough braindead frivulous incompatibilities in Linux.

The *only* thing you can reliably use in #! lines is an interpreter
followed by a single argument with no trailing space. On NetBSD with
bash as /bin/sh:

mjg59@cysteine:/tmp$ cat foo.pl
#!/bin/sh -- # -*- perl -*- -p
mjg59@cysteine:/tmp$ ./foo.pl
/bin/sh: -- # -*- perl -*- -p: unrecognized option

File a bug against perlrun(1).
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org

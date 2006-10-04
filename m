Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWJDEJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWJDEJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWJDEJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:09:00 -0400
Received: from qb-out-0506.google.com ([72.14.204.237]:18448 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932339AbWJDEI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:08:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q9VLNWZhuCiOAkfZpQzIW97FLFsMGKNLKJyoPj/ZnDMxuW5sG96WlS+Ugxhc9YKwkhKIb05G33NP+9RoAguDfqXu1OZ2yvS29LOJWxLfxJUHX5EOhF6sNkhCgXZVJf5spgJch5BNZlD5Vpk5IlVTZ7otSVTRWQ9OdqDytyUmYPQ=
Message-ID: <18d709710610032108w52d69b17mfa585e40ad2ae72c@mail.gmail.com>
Date: Wed, 4 Oct 2006 01:08:57 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: "Chase Venters" <chase.venters@clientec.com>
Subject: Re: Registration Weakness in Linux Kernel's Binary formats
Cc: goodfellas@shellcode.com.ar, "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Kyle Moffett" <mrmacman_g4@mac.com>, endrazine <endrazine@gmail.com>,
       "Stephen Hemminger" <shemminger@osdl.org>, Valdis.Kletnieks@vt.edu,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sincerely think you're all missing the point here.

The observation is in fact something that can be used by rootkit
writers or developers of other forms of malware. Meaning that this is
always something else that people who work to make Linux a safer
environment will have to watch and look for (think of rootkit
detectors, for an example). I'm glad they've reported it, as someone
might be using it already for God knows how long. All very stealthy.
All I can think is that this is a very good opportunity for us to
rethink some designs and see if a little bit of effort wouldn't be
worth the advantages a patch might bring.

Don't get me wrong. I truly appreciate the freedom that Linux
provides, but this "well, root should be able to do anything, anyway"
mentality won't get this OS anywhere security-wise. If everyone
thought like that, then I'd guess that sys_call_table would be an
exported symbol until now, linux-gate wouldn't be randomized, and so
on.

Just a thought.

Cheers,

    Julio Auto

On 10/4/06, Chase Venters <chase.venters@clientec.com> wrote:
> On Tuesday 03 October 2006 14:12, SHELLCODE Security Research wrote:
> > Hello,
> > The present document aims to demonstrate a design weakness found in the
> > handling of simply
> > linked   lists   used   to   register   binary   formats   handled   by
> > Linux   kernel,   and   affects   all   the   kernel families
> > (2.0/2.2/2.4/2.6), allowing the insertion of infection modules in
> > kernel­ space that can be used by malicious users to create infection
> > tools, for example rootkits.
>
> Yay, you've been Slashdotted!
>
> Question: Why did you personally submit this to Slashdot when it is absolutely
> clear that the observation is akin to figuring out a process can call fork()
> and exec() and become "/bin/rm" with an argv of "/bin/rm", "-rf", and "*"?
>
> Is this what you call good marketing?
>
> > POC, details and proposed solution at:
> > English version: http://www.shellcode.com.ar/docz/binfmt-en.pdf
> > Spanish version: http://www.shellcode.com.ar/docz/binfmt-es.pdf
> >
>
> Thanks,
> Chase
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311203AbSCPX10>; Sat, 16 Mar 2002 18:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311195AbSCPX1P>; Sat, 16 Mar 2002 18:27:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20237 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311205AbSCPX1E>; Sat, 16 Mar 2002 18:27:04 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Oops in 2.5.7-pre2: ACPI?
Date: Sat, 16 Mar 2002 23:25:06 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a70k8i$17d$1@penguin.transmeta.com>
In-Reply-To: <20020316213319.Q9664@x3ja.co.uk>
X-Trace: palladium.transmeta.com 1016321196 24688 127.0.0.1 (16 Mar 2002 23:26:36 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 16 Mar 2002 23:26:36 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020316213319.Q9664@x3ja.co.uk>,
Alex Walker  <alex@x3ja.co.uk> wrote:
>
>Up to 2.5.7-pre1 ACPI worked fine with System, Processor and Button
>options enabled.
>
>If I disable all the options, leaving just ACPI support, it still oopss.
>
>If I disable ACPI totally, it boots fine.

There was a big ACPI merge in 2.5.7-pre2, but since the ACPI people
never tested the non-ACPI case, they had broken that horribly by some
bad assumptions they had made.

I fixed the non-ACPI brokenness, which then left the ACPI merge in a
halfway state..  So right now ACPI device initialization doesn't work. 
I'm hoping that the ACPI folks can fix up their broken assumptions soon. 

>If I disable Power management, but leave ACPI and option selected, it
>also oopss.

Right now you need to run 2.5.7-pre2 without any ACPI support
whatsoever, I'm afraid.  I may try to fix it on my own, but I'm still
hoping some official ACPI person will beat me to it. 

		Linus

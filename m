Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310434AbSCLGLW>; Tue, 12 Mar 2002 01:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310431AbSCLGLN>; Tue, 12 Mar 2002 01:11:13 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:65208 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S310430AbSCLGK6>; Tue, 12 Mar 2002 01:10:58 -0500
Message-ID: <01d801c1c98c$aad1dfd0$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
        "Linus Torvalds" <torvalds@transmeta.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203111916000.18604-100000@penguin.transmeta.com> <3C8D7A2A.7040209@mandrakesoft.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
Date: Mon, 11 Mar 2002 22:10:53 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jeff Garzik" <jgarzik@mandrakesoft.com>

> Linus Torvalds wrote:
...
> >One solution may be to have the whole raw cmd thing as a loadable module, 
> >and then I can make sure that it's not even available on the system so 
> >that I have to do some work to find it, and somebody elses program won't 
> >just know what to do.
> >
> >But in that case is should be far removed from the IDE driver - it would 
> >just be a module that inserts a raw request on the request queue, and NOT 
> >inside some subsystem driver that I obviously want to have available all 
> >the time.
> >
> I like this solution, it was the one I was thinking of :)

It leaves me bemused. You speak of a module to install a raw userspace
IO capability. If that module exists the module interface exists. Would
it have to be the module compiled into the kernel that gets run on that
interface? It looks as wide open as ever, to me.

> The entire userspace raw cmd ioctl should be a separate module for 
> precisely the issues you outlined.  If they choose, people can compile 
> that module into the static kernel image, including filter.  Or they can 
> use the module without the filter.  Or they can not use the module at 
> all.  Etc.

Of course, this seems to be one of those compromises between high
availability and high security. It should be made clear that this is
the compromise involved when the raw io filter is compiled in or not.

I'm not sure you can build an unfiltered raw IO capability into the
kernel SCSI, IDE, or anything else and maintain system security.

{^_^}    Joanne


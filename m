Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288696AbSAQNWW>; Thu, 17 Jan 2002 08:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288691AbSAQNWM>; Thu, 17 Jan 2002 08:22:12 -0500
Received: from [195.25.229.189] ([195.25.229.189]:31344 "EHLO
	mailrennes.rennes.si.fr.atosorigin.com") by vger.kernel.org
	with ESMTP id <S288696AbSAQNWH> convert rfc822-to-8bit; Thu, 17 Jan 2002 08:22:07 -0500
Message-ID: <013901c19f59$d72beb50$8a140237@rennes.si.fr.atosorigin.com>
From: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: modules detection
Date: Thu, 17 Jan 2002 14:21:14 +0100
Organization: ENIB - Promo `98
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 17 Jan 2002 13:21:15.0389 (UTC) FILETIME=[D72AB2D0:01C19F59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I need to know (in a script shell for instance) if a running kernel
is compiled with/without module support. I don't have access to the
source tree when detecting (though I have it mounted sometime later).

Reading the source (fs/proc/proc_misc.c), I understand that the file
/proc/modules exists only when modules are supported by the running
kernel. Is that true? If so, can I assume that the following script
is correct?

-=-=-=-
#!/bin/bash
[ -e /proc/modules ] && echo Modules supported by running kernel. \
                     || echo Modules not supported by running kernel.
-=-=-=-

If not, how may I detect module support?

(Yes, I could build two kernels supporting modules vs not supporting
modules, but my machine is quite slow : 2h per compilation :-( ).

Thanks for any reply.

Regards,
Yann E. MORIN.

--
.---------------------------.----------------------.------------------.
|       Yann E. MORIN       |  Real-Time Embedded  | ASCII RIBBON /"\ |
|  phone: (33) 662 376 056  |  Software  Designer  |   CAMPAIGN   \ / |
|   http://ymorin.free.fr   °----------------------:   AGAINST     X  |
| yann.morin.1998@anciens.enib.fr                  |  HTML MAIL   / \ |
°--------------------------------------------------°------------------°



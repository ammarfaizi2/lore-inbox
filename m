Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290743AbSBGRvg>; Thu, 7 Feb 2002 12:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290746AbSBGRv1>; Thu, 7 Feb 2002 12:51:27 -0500
Received: from gold.he.net ([216.218.149.2]:50193 "EHLO gold.he.net")
	by vger.kernel.org with ESMTP id <S290743AbSBGRvG>;
	Thu, 7 Feb 2002 12:51:06 -0500
Reply-To: <jss@pacbell.net>
From: "J.S.S." <jss@pacbell.net>
To: "Drew P. Vogel" <dvogel@intercarve.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel reboot problem [solved]
Date: Thu, 21 Feb 2002 09:53:43 -0800
Message-ID: <PGEMINDOPMDNMJINCKBNAEGPCAAA.jss@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.33.0202071041000.2642-100000@northface.intercarve.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it's a beautiful thing when something finally works that you've been
struggling with for a while.
I loaded the Redhat default .config for i586 and modified it taking out
things I knew I didn't want, especially all the extra modules they select.
Anyway, the install went great - although it didn't work when I tried to use
the initrd image for some reason.  But, I took that line out of lilo.conf,
ran lilo, rebooted and it ran through like it should have.  Now to play
around with the .config file to streamline it more to my machine
configuration.  Thanks everyone for the help! You guys are great.

					JSS

-----Original Message-----
From: Drew P. Vogel [mailto:dvogel@intercarve.net]
Sent: Thursday, February 07, 2002 7:42 AM
To: Todor Todorov
Cc: J.S.S; Linux Kernel Mailing List
Subject: Re: Kernel reboot problem


Forgive me. It is early :]

--Drew Vogel

On Thu, 7 Feb 2002, Drew P. Vogel wrote:

>Well, not having the proper fs drivers compiled in would not cause the
>machine to reboot at that point. The lack of an initrd-2.4.17-10.img file
>probably would though.
>
>--Drew Vogel
>
>On Thu, 7 Feb 2002, Todor Todorov wrote:
>
>>Drew P. Vogel wrote:
>>
>>>What does the initrd= line do, and how does initrd-2.4.17-10.img get in
>>>/boot?
>>>
>>It's a compressed file containing the compiled modules which is needed
>>if a driver should be initialized before mounting the root file system,
>>eg a driver for the root system. As it is in the 2.4.7 image section it
>>refers only to the 2.4.7 kernel and not 2.4.18 (or whatever he tries to
>>compile).
>>
>>And speaking of it - J.S.S., did you take the options from the Red Hat's
>>stock kernel as an example to choose your options? (From your mail I
>>recon that this is one of your first attempts to compile an own kernel,
>>am I correct?) If you did that, you rpobably included the fs driver for
>>your root system as a module and not hardlinked in the kernel - just as
>>Red Hat does? In such case you would need either to provide an initrd
>>image too (`man initrd`), or recompile your kernel with the driver for
>>the root filesystem ( ext2 or/and ext3 or reiserfs, don't know how you
>>formated your linux partition(s) ) with <y> as option for it instead of
>><m>.....
>>
>>Stupid me for not suggesting to check that in the first mail :-/
>>
>>Hope you will locate the error quickliy.
>>
>>Cheers
>>
>>--
>>
>>Todor Todorov           <ttodorov@web.de>
>>Networkadministration   <todor.todorov@skr-skr.de>
>>SKR GmbH & Co. KG       http://www.skr-skr.de
>>
>>-----------------
>>"Only two things are infinite, the universe and the
>> human stupidity, and I'm not sure about the former"
>>                               - Einstein
>>
>>
>>
>>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>




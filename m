Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287193AbSBGPyW>; Thu, 7 Feb 2002 10:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSBGPyE>; Thu, 7 Feb 2002 10:54:04 -0500
Received: from gold.he.net ([216.218.149.2]:9482 "EHLO gold.he.net")
	by vger.kernel.org with ESMTP id <S287193AbSBGPxs>;
	Thu, 7 Feb 2002 10:53:48 -0500
Reply-To: <jss@pacbell.net>
From: "J.S.S." <jss@pacbell.net>
To: "Drew P. Vogel" <dvogel@intercarve.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel reboot problem
Date: Thu, 21 Feb 2002 07:56:25 -0800
Message-ID: <PGEMINDOPMDNMJINCKBNOEGKCAAA.jss@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.33.0202071012250.2642-100000@northface.intercarve.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, i'm going to try this again (and again as long as it takes), but this
time I loaded the .config file from Redhat and am going to take out the
stuff I don't want.  Actually I should have done this from the beginning.
However, I can already see some of the things that I should have enabled
just from looking at their configuration.  I'll keep you posted on the
progress.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Drew P. Vogel
Sent: Thursday, February 07, 2002 7:13 AM
To: Todor Todorov
Cc: J.S.S; Linux Kernel Mailing List
Subject: Re: Kernel reboot problem


Well, not having the proper fs drivers compiled in would not cause the
machine to reboot at that point. The lack of an initrd-2.4.17-10.img file
probably would though.

--Drew Vogel

On Thu, 7 Feb 2002, Todor Todorov wrote:

>Drew P. Vogel wrote:
>
>>What does the initrd= line do, and how does initrd-2.4.17-10.img get in
>>/boot?
>>
>It's a compressed file containing the compiled modules which is needed
>if a driver should be initialized before mounting the root file system,
>eg a driver for the root system. As it is in the 2.4.7 image section it
>refers only to the 2.4.7 kernel and not 2.4.18 (or whatever he tries to
>compile).
>
>And speaking of it - J.S.S., did you take the options from the Red Hat's
>stock kernel as an example to choose your options? (From your mail I
>recon that this is one of your first attempts to compile an own kernel,
>am I correct?) If you did that, you rpobably included the fs driver for
>your root system as a module and not hardlinked in the kernel - just as
>Red Hat does? In such case you would need either to provide an initrd
>image too (`man initrd`), or recompile your kernel with the driver for
>the root filesystem ( ext2 or/and ext3 or reiserfs, don't know how you
>formated your linux partition(s) ) with <y> as option for it instead of
><m>.....
>
>Stupid me for not suggesting to check that in the first mail :-/
>
>Hope you will locate the error quickliy.
>
>Cheers
>
>--
>
>Todor Todorov           <ttodorov@web.de>
>Networkadministration   <todor.todorov@skr-skr.de>
>SKR GmbH & Co. KG       http://www.skr-skr.de
>
>-----------------
>"Only two things are infinite, the universe and the
> human stupidity, and I'm not sure about the former"
>                               - Einstein
>
>
>
>



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


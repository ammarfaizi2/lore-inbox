Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQLNOQo>; Thu, 14 Dec 2000 09:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbQLNOQe>; Thu, 14 Dec 2000 09:16:34 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:22547 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129886AbQLNOQ3>; Thu, 14 Dec 2000 09:16:29 -0500
Message-Id: <200012141345.eBEDjrs46412@aslan.scsiguy.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: Your message of "Thu, 14 Dec 2000 11:22:17 +0100."
             <20001214112217.A9662@werewolf.able.es> 
Date: Thu, 14 Dec 2000 06:45:53 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I tried it against clean 2.2.18 and patches did not work.
>Some drawbacks:
>- the patch adds config info for AIX7XXX in the top level Makefile, instead
>of in the Makefile in the scsi dir.

Yes, this will be fixed today.  The aic7xx directory will build the module
or main driver file into the scsi directory so that no files need to be
renamed.  This also means that the module name can remain the same.

>- The subdir for aic7xxx has not a Makefile, or at least it is not created
>with the patches for 2.2.18.

It was supposed to be part of the patches for 2.2.18 (each kernel version
requires a slightly different Makefile which is why it is not included
in the main source ball).

>- The structure of the driver (all files inside a subdir) has changed, so
>you get the old files still there.

There is no way to remove those files other than instructing the user to
do so or to execute a script.

>I am going to try to clean up the thigs to make the driver easily updated:
>- First thing is to move all files in the actual 5.1.31 to INSIDE the dir
>  and change the scsi/Makefile to build it as a SUB_DIR.
>- Change names of files: aic7xxx.o has to be built from many *.c, so you
>  should rename the aic7xxx.c to something like aic7xxx_main.c.
>- Then you have the aic7xxx subdir and you can add a similar aic7xxx-6 subdir
>and even add an exclusive option to build one or the other, the second
>marked EXPERIMENTAL.

Blah.  I'd rather prove the utility of the new driver prior to having
it incorporated into the kernel tree and at that point have it as a
full replacement.  Otherwise there is just too much room for confusion.

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272246AbRIERwW>; Wed, 5 Sep 2001 13:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272249AbRIERwN>; Wed, 5 Sep 2001 13:52:13 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:56326 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272246AbRIERv5>; Wed, 5 Sep 2001 13:51:57 -0400
Message-ID: <3B9665FB.C3E5DCAF@t-online.de>
Date: Wed, 05 Sep 2001 19:50:51 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: oscarcvt@galileo.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel panic, a cry for help
In-Reply-To: <E15efKa-0006Cj-00@the-village.bc.nu> <999707202.3b965242145d5@webmail.galileo.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oscarcvt@galileo.edu schrieb:
> 
> ive started with a rescue disk, /sbin/init is present, lilo.conf seems fine,
> where might i go next?
> 

Is /sbin/init executable ?

Check it with ls:
ls -l /sbin/init should get you
-rwxr-xr-x    1 root     root        26876 Jun 21 20:58 /sbin/init

Is it the correct file ?
Compare it against another maschine or copy it from there (same
Distribution, save the old file)

Try giving the Kernel a parameter at bootime: at the LILO-Prompt, press
<tab>, then enter the imagename followed by the parameter, e.g. "linux
init=/bin/bash"
The kernel should boot up and give you a single (root-) shell.

Uses the kernel the right root-device ?
If not, give it to him at boottime like the init=Stuff: "root=/dev/hda1"
says the kernel to mount /dev/hda1 as rootdevice ("/") and search on
this device for "init".

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbTFZJqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 05:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbTFZJqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 05:46:14 -0400
Received: from [203.124.166.107] ([203.124.166.107]:20491 "EHLO
	mail.pune.nevisnetworks.com") by vger.kernel.org with ESMTP
	id S265515AbTFZJqL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 05:46:11 -0400
content-class: urn:content-classes:message
Subject: RE: INIT:ld"2" respawning too fast:disabled for 5 minutes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Thu, 26 Jun 2003 15:31:29 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Message-ID: <36993D449C7FA647BF43568E0793AB3E061D2D@nevis_pune_xchg.pune.nevisnetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: INIT:ld"2" respawning too fast:disabled for 5 minutes
Thread-Index: AcM7xt8XWg+9BPZbSearvcCSbCZHFgAAkk/Q
From: "Girish Kale" <girish.kale@nevisnetworks.com>
To: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please see inline with >>

Regards,
Girish
-----Original Message-----
From: Zeno R.R. Davatz [mailto:zdavatz@ywesee.com] 
Sent: Thursday, June 26, 2003 3:05 PM
To: linux-kernel@vger.kernel.org
Subject: Re: INIT:ld"2" respawning too fast:disabled for 5 minutes

Hi 

thanks for the input.

You mean I need to check the config in 'make menuconfig'?
>> yes

Any idea where exactly I could look?
>> no. But when the kernel is booting, you can see if it is giving any
errors. That can be a clue.

Also, how did you boot into the old kernel, getting your maschine back
up again? I only manage to reinstall from zero...

>> When I experimented with my new kernel I added another entry in my
grub file. That gave me 2 options - to load from my previous kernel or
to load from my new kernel. So everytime things went wrong with my new
kernel I booted from the new kernel (which was always intact, not
overwritten by the new kernel), made modifications for the new kernel
and then tried out with the new kernel.


Thanks for your time and help.

Zeno

On Thu, 26 Jun 2003 14:44:34 +0530
"Girish Kale" <girish.kale@nevisnetworks.com> wrote:

> Hi,
> 
> What this message means is that :
> 
> "if you make a mistake that prevents a particular program from
starting,
> and the action is respawned, init might get caught in a loop. That is,
> init tries to start the program, cannot, for whatever reason and then
> tries to start it again. If init finds that it is starting the program
> more than 10 times within 2 minutes, it will treat this as an error
and
> stops trying. Typically you will get messages in the system log that
the
> process is "respawning too rapidly"." Please read :
> 
> http://www.linux-tutorial.info/cgi-bin/display.pl?65&0&64&0&3
> 
> I also faced a similar problem - it gave me INIT:ID"1" respawning too
> fast" , when I tried to login to my machine. This got resolved when I
> reconfigured the kernel. But yet to figure out the "exact" change
which
> causes my problem.
> 
> Regards,
> Girish
> 
> -----Original Message-----
> From: Zeno R.R. Davatz [mailto:zdavatz@ywesee.com] 
> Sent: Thursday, June 26, 2003 2:28 PM
> To: linux-kernel@vger.kernel.org
> Subject: INIT:ld"2" respawning too fast:disabled for 5 minutes
> 
> Hi List
> 
> I succeded twice in making a kernel_image with the Debian
kernel-package
> and installaing the .deb file (2.4.18, 2.4.20).
> 
> My Installation where I boot from is bf24-2.4.20 (floppies).
> 
> I download the kernel sources to /usr/src/linux-2.4.21 I do make
clean,
> make menuconfig and then make-kpkg -rev ywesee.1 kernel_image. 
> 
> The maschine ends the compilation just fine and I do dpkg -i
> kernel_image-2.4.21-ywesee.1-i386.deb.
> 
> Then I reboot, everythings starts fine _without a kernel panic.
> 
> But: After starting the cron daemon I get:
> INIT:ld"2" respawning too fast:disabled for 5 minutes 
> 
> I get this several times...
> 
> Why do I get this message and how can I get rid of it so my 2.4.21
boots
> nicely.
> 
> (I need to start my installation again from the beginning as I can not
> boot into the old system).
> 
> Many thanks in advance for any help and hints.
> 
> Zeno
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Mit freundlichen Gruessen / Best regards

Zeno Davatz
Strategie und Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.generika.cc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

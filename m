Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271234AbRHOPqH>; Wed, 15 Aug 2001 11:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271233AbRHOPp5>; Wed, 15 Aug 2001 11:45:57 -0400
Received: from mrelay.cc.umr.edu ([131.151.1.89]:32526 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S271236AbRHOPpv>;
	Wed, 15 Aug 2001 11:45:51 -0400
Message-ID: <F349BC4F5799D411ACE100D0B706B3BB7690AE@umr-mail03.cc.umr.edu>
From: "Neulinger, Nathan" <nneul@umr.edu>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Problems with 3ware error event notification in kernel
Date: Wed, 15 Aug 2001 10:46:01 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a situation with the 3ware driver and 3dm monitor where it appears
to stop receiving notification of status changes from the kernel.

I've seen this with 2.2.19+variouspatches and 2.4.7-ac3. (On some other
machines, it appears to work fine.)

Basically, all of the real-time monitoring and instantaneous status request,
as well as configuration change, etc. stuff all works fine, but after a
while, the 3dm monitor no longer gets messages talking about drive failure
(pulling a drive on hot-swap tray) or when the rebuilds start/stop. Even
restarting the 3dm monitor doesn't seem to help this.

Strace doesn't seem to work on the 3dm executable since it's threaded... (Is
there a way to get that to work?)

Anyone have any ideas on this or have you seen this? The important thing is,
if I reboot the server it's on, I'll generally be able to get a few alert
messages, but after some time period (I think it's time based and not
#-of-alerts based) it no longer receives new alert messages.

3ware tech support doesn't have any idea on what could be wrong and didn't
have any suggestions of what to try other than harping about what version of
sendmail I'm running, etc. (Turning off the mail support didn't have any
effect on the alert processing.)

----

On a side note - is anyone aware of any effort to reverse engineer the
status probing code so that we could monitor the raid arrays using something
other than 3wares 3dm tool? I presume it's just a matter of knowing the
right ioctl's and parms to issue, but there is no info on this, and 3ware
has no plans (according to tech support) to release any documentation or
source for the monitoring code/protocols. Being able to strace the 3dmd
would likely make this alot easier, but haven't been able to get strace to
work against it.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216

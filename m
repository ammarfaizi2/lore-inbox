Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274044AbRISNCN>; Wed, 19 Sep 2001 09:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274045AbRISNCD>; Wed, 19 Sep 2001 09:02:03 -0400
Received: from Prins.externet.hu ([212.40.96.161]:55304 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S274044AbRISNBw>; Wed, 19 Sep 2001 09:01:52 -0400
Message-ID: <3BA897CC.5040301@externet.hu>
Date: Wed, 19 Sep 2001 15:04:12 +0200
From: "Forsz 98 Kft." <forsz@externet.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010815
X-Accept-Language: en, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-pre12 (SMP) + preempt + ext3
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I just wanted to let everyone know that the above combination nicely works.
I applied the sysrq.c/nmi.c fix posted by Keith Owen, the preempt patch
and the ext3-2.4-0.9.9-2410p4 patch.

The last one produced rejects in 5 files. All of them was obvious to fix 
by hand
except the one in vmscan.c which I ignored completely. This patch can be 
found at:

ftp://ftp.externet.hu/pub/people/zboszor/ext3-2.4-0.9.9-2410p12.gz

This combination works for 5 hours now.

I did not do a very scientific test but this is what I tried:
on a 2way PIII/500 384MB memory machine, running the
latest Ximian GNOME-1.4 on RH6.2. The kernel is compiled with
egcs-1.1.2, since I do not have anything newer on this machine yet.

In one gnome-terminal I run "dd if=/dev=hda of=/dev/null".
In another, I run a kernel compilation: "make dep clean ; make -j5 
bzImage modules".
In the meantime, I am browsing with Mozilla-0.9.3 from the above mentioned
GNOME release. The Mozilla startup time almost halved. (It is an impression,
not a timed fact, though.) I even tried a vmware-2.0.4 session, it works 
with
the last vmware patch for linux-2.4.9.

It seems that 2.4.10 will be the Holy Grail. :-)

Regards,
Zoltan Boszormenyi




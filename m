Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131573AbRDCAIv>; Mon, 2 Apr 2001 20:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRDCAIl>; Mon, 2 Apr 2001 20:08:41 -0400
Received: from smtp7.xs4all.nl ([194.109.127.133]:31195 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131832AbRDCAI2>;
	Mon, 2 Apr 2001 20:08:28 -0400
From: Stefan Linnemann <mazur@xs4all.nl>
Organization: Dis.
Date: Tue, 3 Apr 2001 02:08:13 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Sandisk flashcard reader on 2.4.2.  It works.  Sort of.
MIME-Version: 1.0
Message-Id: <01040302081301.00789@mazur.xs4all.nl>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PLease Cc: all responses to mazur@xs4all.nl.

Hiya,

since I'm not on the list, and my experience with and knowledge of kernel 
internals are negligable, please keep in mind to Carbon copy all forcoming 
relevant conversation to me. Thank you.

Ok, I bought a Nikon Coolpix 990, aand to download the ppix to my Linux PC at 
home a SanDisk ImageMate SDDR-01.  That's parallel IDE.  At the time, I ran 
2.2.17, which of course didn't touch the thing with a 10 parsecs pole.  Som 
searching on the web led me to two conclusions:

1. This thing is either new or scorned.
2, There is a patch at http://www.electricgod.net/~moomonk/epat/ which may or 
may not help.

All the time during this story a 16 Mb SanDisk CompactFlash card is in the 
reader, unles otherwise specified.

So I applied the patch to the 2.2.17 kernel, remade, and rebooted.  No dice.  
Several kernel reconfigurations and rebots later still nothing, it seemed.  
So I downloaded and installed 2.4.2, which was mentioned to problably include 
the necessary features.  I copied .config from the 2.2.17, superficially 
checked the config, and remade and rebooted.

This was where I noted, that the parport, paride, epat and pd modules didn't 
get installed as modules at all.  I havnet dug into the why of that, let 
those familiar with the processes and Makefiles do that.  So I reconfigured 
to get those into the kernel, and remade and rebooted.  No dice, so I 
succesfully again applied the same patch, configured it into the kernel and 
remade  and rebooted.  No SanDisk. For some reason or another I rebooted 
again, and lo and behold,  we have a SanDisk.  I mount it ok, cd 
/sandisk/dir/, mv * elsewhere, my system hangs.  Reset.  cp * hangs the 
system as well,  so I do a for i in *; do; cp $i /there; sync; done;

The system hangs whenever I try to copy a certain picture.  (No, it doesn't 
contain nudiepixels.)  Luckily, I didn't care much about that one.  Since the 
start of this story and "now" I've aqcuired an 128 Mb card, and shot some 
pictures using it.  So I unmount my 16 Mb one, swicth cards, and mount the 
device again.  Or so I hoped.  System hangs on the mount operation.  And no
CTRL-ALT-DEL to go down more or less gracefully.  It really hangs, like 
whenever the patched system barfs on the SanDisk.

And today, several days later, the system even refuses to see the little 
bugger, even the lasst time, without any card it it's waiting little mouth.

So the message is: Yes, it could work, but with the patch from 
http://www.electricgod.net/~moomonk/epat/ it's slightly better working than 
without it.

What am I to do?

With kind regards,
Stefan.
Please Cc: reactions to me.
-- 
Stefan Linnemann                        http://www.xs4all.nl/~mazur/
Systems programmer Unix         ICQ: 25314387

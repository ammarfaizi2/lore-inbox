Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291383AbSBHCy5>; Thu, 7 Feb 2002 21:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291382AbSBHCyp>; Thu, 7 Feb 2002 21:54:45 -0500
Received: from mx3.fuse.net ([216.68.1.123]:48109 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id <S291383AbSBHCye>;
	Thu, 7 Feb 2002 21:54:34 -0500
Message-ID: <3C633DDB.9050607@fuse.net>
Date: Thu, 07 Feb 2002 21:54:19 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020203
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Mouse under 2.5.3-dj3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To follow up on my previous postings of a long while ago.

I have a very boring trackpad mouse on a Sony VAIO R505JE laptop.  At 
least, 2.4.18-pre7 thinks it's normal PS/2 and uninteresting.  2.5.3-dj* 
on the other hand, seems to be horribly confused.  I rebuilt it with 
everything mouse related as modules just so I didn't have to reboot when 
it misdetected my mouse.

First, I modprobe mousedev, then psmouse.
Mousedev always is cool and loads without a problem, printing out its 
"PS/2 mouse device common for all mice" message.

~90% of the time, psmouse does not detect a mouse.  Doesn't work, obviously.
~5% of the time, psmouse reports I have a "PS/2 Generic Mouse on 
isa0060/serio1".
    At such times, the mouse works, but a complete cross on the trackpad 
is ~100 pixels at best.
~1% of the time, psmouse blurts "Failed to enable mouse on 
isa0060/serio1"  Here the mouse does not work.
~4% of the time, psmouse prints "PS/2 Logitech Mouse on isa0060/serio1" 
 This is the correct mode of behavior.

As it is I run "modprobe mousedev; while < /dev/zero; do modprobe 
psmouse; echo -n "a"; sleep 1; done" and wait for the Logitech message 
to give the loop a Ctrl-C.  There has to be a better way, and more 
information I can provide.

FYI, keyboard glitches *seem* to have disappeared.

--Nathan



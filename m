Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131080AbQLDHFT>; Mon, 4 Dec 2000 02:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131131AbQLDHFK>; Mon, 4 Dec 2000 02:05:10 -0500
Received: from [195.77.25.34] ([195.77.25.34]:34826 "EHLO dmz1.ict.es")
	by vger.kernel.org with ESMTP id <S131080AbQLDHFA>;
	Mon, 4 Dec 2000 02:05:00 -0500
Message-ID: <3A2B3AF3.CF6641B9@ict.es>
Date: Mon, 04 Dec 2000 07:34:27 +0100
From: Jordi Colomer <jco@ict.es>
Organization: ICT Electronics S.A.
X-Mailer: Mozilla 4.75 [es] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Soundconfig
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

There is a little bug in the kernel file drivers/sound/Config.in for ARM
machines.

When I do make xconfig, an error shows up. The cause is in line 11 of
this file :

if [ "$CONFIG_SA1100_ASSABET" = "y" -o "$CONFIG_SA1100_BITSY" = "y" -o \
     "$CONFIG_SA1100_PANGOLIN" = "y" -o $CONFIG_SA1100_FREEBIRD = "y" -o
\
     "$CONFIG_SA1100_YOPY" = "y" ]; then
    dep_tristate '  Assabet/Bitsy/Pangolin/Yopy audio support (UDA1341)'
CONFIG_SOUND_UDA1341 $CONFIG_SOUND
fi                                 

                                                                                 
Note that $CONFIG_SA1100_FREEBIRD must be quoted :
"$CONFIG_SA1100_FREEBIRD".

That's all.

Thank you for your work.

Jordi Colomer.

P.S. : This message was sent originally to mec@shout.net, but he replied
:

"I am not actively maintaining this file any more.  Please send a copy
of your letter to linux-kernel@vger.kernel.org.  Feel free to quote my
e-mail to other people if you think it will be helpful."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

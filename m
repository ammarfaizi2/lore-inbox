Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271611AbRHXWmg>; Fri, 24 Aug 2001 18:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271613AbRHXWm1>; Fri, 24 Aug 2001 18:42:27 -0400
Received: from web10908.mail.yahoo.com ([216.136.131.44]:13062 "HELO
	web10908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271611AbRHXWmQ>; Fri, 24 Aug 2001 18:42:16 -0400
Message-ID: <20010824224232.52238.qmail@web10908.mail.yahoo.com>
Date: Fri, 24 Aug 2001 15:42:32 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: [IDEA+RFC] Possible solution for min()/max() war
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone,

	At the risk of igniting another long-drawn-out flamewar over the
min()/max() macros, I have an idea.

	There is a section in the config dialogs labeled "Kernel hacking."
Under it there is the SysRQ option. Why don't we put an entry under that
dialog and label it "Use new min()/max() macros" and make it a y/n field.
Then we can add dozens of warnings to the help dialog about it, and allow
the user/hacker to select the macro they want.

	In any code which uses the macros, you can simply do this:

#include <linux/config.h>
....
#ifdef CONFIG_USE_NEW_MINMAX
	minimum = min(int, number[0], number[1]);
#else
	minimum = min(number[0], number[1]);
#endif

	This way, some hackers can use the two-arg min()/max() inside an #ifdef block,
other hackers can use the three-arg min()/max() inside an #ifdef block, 
and people who don't care can select either.

	Comments, flames, suggestions, anyone? If the output is good, I'll
publish a patch which will add the Config.in option and default it to
CONFIG_USE_NEW_MINMAX=y, since that was the decree of the Great Penguin Overlord ;)

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbRBJLPz>; Sat, 10 Feb 2001 06:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbRBJLPq>; Sat, 10 Feb 2001 06:15:46 -0500
Received: from B3b51.pppool.de ([213.7.59.81]:7182 "EHLO
	velvet.programmfabrik.de") by vger.kernel.org with ESMTP
	id <S129453AbRBJLPk>; Sat, 10 Feb 2001 06:15:40 -0500
Message-ID: <3A85329E.75AAC342@programmfabrik.de>
Date: Sat, 10 Feb 2001 12:22:54 +0000
From: Martin Rode <Martin.Rode@programmfabrik.de>
Organization: programmfabrik GmbH
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MM Problems with 2.2.18 even more with > 2.2.19pre2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing problems on our K7 600Mhz, 256MB box. After about one week
uptime we certainly run into 

vm_trying_to_free_unused pages. 

With > 2.2.19pre2 the hylafax daemon would not even start without
causing a kernel oops. I was not able to capture these oopses, but they
definitely were about memory management. Cannot handle null pointer ...
at virtual address 00000000 (it was all zeros). And at the end of the
oops the line started with EIP. That's all I remember. 

Is the AA VM keener on the quality of the memory? Do we have bad memory
here? Can I test that thourougly somehow?

I had to bring the box up again and bootet into 2.2.18 which stands up
at least for a week under normal load. We are three developers who use
the box as our main application server. That is StarOffice / Xemacs /
Netscape loading / unloading all the time.

Offtopic:
_Finally_ I tried to run 2.4.1 on that box (I have the fileserver on
2.4.1., uptime 6 days now). I can boot into runlevel 1, runlevel 2 does
not work. It stops at "Bringing up interface lo". An strace shows that
it continously tries to poll from 127.0.0.1 but the poll times out. The
system is RH 6.2. based patched for 2.4.

Any help is much appreciated.

Please also reply to martin@programmfabrik.de since I'm not a subscriber
to linux-kernel (any more).

Regards,

Martin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRAOS4J>; Mon, 15 Jan 2001 13:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbRAOSzx>; Mon, 15 Jan 2001 13:55:53 -0500
Received: from pop.gmx.net ([194.221.183.20]:45045 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129632AbRAOSzg>;
	Mon, 15 Jan 2001 13:55:36 -0500
Message-ID: <3A63469D.9010403@gmx.de>
Date: Mon, 15 Jan 2001 19:51:09 +0100
From: Ronny Buchmann <rbla@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17 i686; de-AT; 0.7) Gecko/20010105
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug (isdn-subsystem?) in 2.4.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i have the following problem with kernel 2.4.0 (also with -ac6):

when trying to connect two isdn channels (/dev/ttyI0 and /dev/ttyI1) 
both initialized with "AT &E123 &L123 &R9600 S19=0 S0=1"
i get after "ATDT 123" (123 stands for my number)

kernel BUG at slab.c:1095!
invalid operand: 0000
CPU: 0
......

(if you need the other numbers or anything else, ask me, i can reproduce 
it easily)

syslog shows (with isdnctrl verbose 3):
isdn_net: call from 0987123,7,0 -> 123
isdn_net: call from 0987123 -> 0 123, ignored
isdn_tty: call from 0987123, -> RING on ttyI1

than the crash

(987 stands for the area code)

my system:
redhat 7.0 (kernel compiled with gcc-2.96, egcs-1.1.2 and gcc-2.95.1 
same result with each of them)
isdn-card: avm fritzcard pnp

btw, it is working with 2.2.17 and the avm driver on suse 6.4

tia
ronny

ps: im not on linux-kernel, so please cc to me



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

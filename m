Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbRAFPiR>; Sat, 6 Jan 2001 10:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131912AbRAFPiI>; Sat, 6 Jan 2001 10:38:08 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:54721 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S131868AbRAFPh4>;
	Sat, 6 Jan 2001 10:37:56 -0500
Message-ID: <3A573BD2.C7F7771F@voicenet.com>
Date: Sat, 06 Jan 2001 10:37:54 -0500
From: safemode <safemode@voicenet.com>
Organization: none
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ip_conntrack locks up hard on 2.4.0 after about 10 hours
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that for one reason or another, ip_conntrack totally locks (not
removeable) after about 10 hours of continued use.  All i found were
these messages in my dmesg output
Jan  6 06:18:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
when=0x5d9e, caller=c01a6bf1
Jan  6 06:18:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
when=0x5b2f, caller=c01a6bf1
Jan  6 06:18:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
when=0x56bb, caller=c01a6bf1
Jan  6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
when=0x217db, caller=c01a6bf1
Jan  6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
when=0x2363e, caller=c01a6bf1
Jan  6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
when=0x21b64, caller=c01a6bf1
Jan  6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
when=0x1fa85, caller=c01a6bf1

This makes it impossible to make any sort of network socket connection
and all prior connections died.  As i said you cannot remove the module
to reset ip_conntrack and i'm not sure what could have caused this as it
did work up until i woke up this morning, with a total running time of
about 10 hours or so.  I'd consider this bug rather important, if anyone
thinks this is not an ip_conntrack bug and rather something that has
changed that i havn't read about, help would be nice. :)    i have been
using iptables since it came out though and ip_conntrack has only been
bad once before,   on test5 when it wouldn't kill old dead socket
connections and eventually starved itself of free sockets.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

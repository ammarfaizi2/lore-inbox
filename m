Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319291AbSHGTly>; Wed, 7 Aug 2002 15:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319292AbSHGTly>; Wed, 7 Aug 2002 15:41:54 -0400
Received: from klaatu.zianet.com ([204.134.124.201]:20943 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S319291AbSHGTkw>;
	Wed, 7 Aug 2002 15:40:52 -0400
Message-ID: <3D517A78.704@zianet.com>
Date: Wed, 07 Aug 2002 13:52:24 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020802
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at tg3.c:1557
References: <Pine.LNX.4.44.0208071332110.3394-100000@pc40.e18.physik.tu-muenchen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried this on a dual Athlon box with two 7850's in it
and a 3C996B-T as well.  Lucky for me though, this
error did not show up.  I transfered/received two 800MB files
to the RAID and it held up ok.  What driver version are you
using? Or even kernel version.

Steve

Roland Kuhn wrote:

>Dear kernel hackers!
>
>I've been chasing this bug now for weeks without further ideas, so please 
>tell me your thoughts about it:
>
>On a dual Athlon MP with a 3ware-7850 RAID (640GB RAID-5) and 3C996B-T GE 
>NIC I can crash the machine with the above BUG message in virtually no 
>time simply by copying data both ways between the RAID and the NIC. The 
>BUG message shows that this can happen any time, it doesn't matter if the 
>interrupt is received in cpu_idle or something else. I tried noapic, but 
>to no avail.
>
>Does anybody know about this problem?
>How can I get more debugging information?
>Can the driver be patched to gracefully handle this situation, e.g. by 
>resetting the card and trying again?
>
>What I've found out till now is only that the kernel's and the NIC's view 
>of the world seem to be inconsistent :-(
>
>For our application stability is much more important than a few TCP 
>retransmits...
>
>Thanks in advance,
>					Roland
>
>+---------------------------+-------------------------+
>|    TU Muenchen            |                         |
>|    Physik-Department E18  |  Raum    3558           |
>|    James-Franck-Str.      |  Telefon 089/289-12592  |
>|    85747 Garching         |                         |
>+---------------------------+-------------------------+
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>




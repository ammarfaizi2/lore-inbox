Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131151AbRCWOyT>; Fri, 23 Mar 2001 09:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131175AbRCWOyK>; Fri, 23 Mar 2001 09:54:10 -0500
Received: from netel-gw.online.no ([193.215.46.129]:14606 "EHLO
	InterJet.networkgroup.no") by vger.kernel.org with ESMTP
	id <S131151AbRCWOx6>; Fri, 23 Mar 2001 09:53:58 -0500
Message-ID: <3ABB6120.C8455DD8@powertech.no>
Date: Fri, 23 Mar 2001 15:43:44 +0100
From: Geir Thomassen <geirt@powertech.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Serial port latency
In-Reply-To: <3ABA42A8.A806D0E7@powertech.no> <20010323002516.B126@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem solved !

The main problem was that I didn't know that the equipment used
DTR as character acknowledge (not RTS/CTS which is common for flow
control). I didn't even bother to look at those lines with the
oscilloscope. Now the software runs fine with negligible latency.

Now the total latency is so low that the low_latency option to
setserial really matters, it reduces the total run time of my
program with 38 %

I don't get any measurable speed improvement by forcing the UART
to be detected as a 8250 or a 16450 though.

I have not tested with HZ=1000.

All in all, my problem is solved, thank you all.

Geir

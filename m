Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129221AbQKBLJM>; Thu, 2 Nov 2000 06:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbQKBLJC>; Thu, 2 Nov 2000 06:09:02 -0500
Received: from inet-smtp4.oracle.com ([209.246.15.58]:13540 "EHLO
	inet-smtp4.us.oracle.com") by vger.kernel.org with ESMTP
	id <S129221AbQKBLIt>; Thu, 2 Nov 2000 06:08:49 -0500
Message-ID: <3A014B52.D4F5AD53@oracle.com>
Date: Thu, 02 Nov 2000 12:09:06 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sean Hunter <sean@dev.sportingbet.com>
CC: matthew <matthew@mattshouse.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 Sluggish After Load
In-Reply-To: <Pine.LNX.4.21.0011010845210.6574-100000@localhost.localdomain> <20001101152629.B31394@bart.dev.sportingbet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter wrote:
> 
> Pardon my speculations (if I am wrong), but isn't this an oracle question?

Maybe, maybe not... what Oracle version ?

> Isn't oracle killing the server by trying to clean up 1800 connections all at
> once?  When they're all connected, most of the work is done by one or two
> oracle processes, but when you kill your ddos thing, all of the oracle
> listeners (of which there is one per connection), steam in and try to clean up.

PMON does the cleanup, so you may have 1 process pegging your CPU at 100%,
 which is not what you see. How does your stress tester work exactly and
 what happens when you stop it ? (my guess is that shadow processes may
 have gone into a CPU loop if detached from the calling process and yes
 that would be abnormal behavior on Oracle's side).

> I thought oracle had an internal connection limit (on our servers it is set to
> 440 connections), anyways.

If Oracle couldn't manage 1800 connections that would be bad news :)


Thanks & ciao,

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.18p18/2.4.0-t10p7 glibc-2.1.94 gcc-2.95.2 binutils-2.10.0.33
Oracle: Oracle8i 8.1.6.1.0 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSC2AI0>; Thu, 28 Mar 2002 19:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313306AbSC2AIQ>; Thu, 28 Mar 2002 19:08:16 -0500
Received: from web21305.mail.yahoo.com ([216.136.129.141]:5984 "HELO
	web21305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313307AbSC2AIG>; Thu, 28 Mar 2002 19:08:06 -0500
Message-ID: <20020329000805.19251.qmail@web21305.mail.yahoo.com>
Date: Thu, 28 Mar 2002 16:08:05 -0800 (PST)
From: chiranjeevi vaka <cvaka_kernel@yahoo.com>
Subject: need help with timers
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am trying to add my own timer in tcp layer to
implement different functionality. I am adding this
timer in sock structure. I can initialize the timer
and modify the timer in my timer handler function. I
want to delete the added timer while closing the
connection.

Right now I am doing this in the closing part of the
TCP. That is in tcp_fin function for cases

TCP_ESTABLISHED
TCP_FIN_WAIT1
TCP_FIN_WAIT2

what is happeneing is if I call close(sockid) then
these functions are getting invoked and my timer is
deleting properly. If I don't call close(sockid) and
the normal user program terminates without calling the
close(sockid), then the timer is not getting deleted
and it is triggering always infinitely. So can you
please tell me where exactly I can delete the timer
however I close the connection, like from the user
level even if I don't call close explicitly or if I
press ctrl+c while data is passing between peers.

Thank you,
Chiranjeevi.

__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/

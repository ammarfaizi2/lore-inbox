Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289277AbSBJEmL>; Sat, 9 Feb 2002 23:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289288AbSBJEmC>; Sat, 9 Feb 2002 23:42:02 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:60621 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289277AbSBJElz>; Sat, 9 Feb 2002 23:41:55 -0500
From: "Nivedita Singhvi" <nivedita@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: tcp_keepalive_intvl vs tcp_keepalive_time?
To: landley@trommello.org
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF46DAF8B5.5C736002-ON65256B5C.0018A2C8@boulder.ibm.com>
Date: Sun, 10 Feb 2002 10:10:15 +0530
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/09/2002 09:41:53 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Would someone be kind enough to explain the difference between
> tcp_keepalive_intvl and tcp_keepalive_time?
> Documentation/filesystems/proc.txt says tcp_keepalive_time is the
interval
> between sending keepalive probes, but doesn't mention
tcp_keepalive_intvl...

tcp starts a keepalive timer for each connection. if the connection is idle
for tcp_keepalive_time seconds, it starts sending probes to the other end.
It sends a maximum of tcp_keepalive_probes each tcp_keepalive_intvl
seconds apart, and if the other end hasnt responded by then, it drops the
connection.

default values:

tcp_keepalive_intvl = 75 seconds
tcp_keepalive_probes = 9
tcp_keepalive_time = 7200 seconds (2 hours)

> The problem I'm trying to track down is ssh connections where the
connection
> times out but the session doesn't go away until a key is pressed.  (I.E.
> blocking reads don't notice the connection going down underneath them,
not
> even if left overnight.)

not clear from the info here whats happening in your case...
(stats?)

> Rob

thanks,
Nivedita



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbRCGECS>; Tue, 6 Mar 2001 23:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130004AbRCGECJ>; Tue, 6 Mar 2001 23:02:09 -0500
Received: from 64-60-75-69-cust.telepacific.net ([64.60.75.69]:61202 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S129991AbRCGEB6>; Tue, 6 Mar 2001 23:01:58 -0500
Message-ID: <3AA5B21D.B02B6885@ixiacom.com>
Date: Tue, 06 Mar 2001 19:59:25 -0800
From: Bryan Rittmeyer <bryan@ixiacom.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: conducting TCP sessions with non-local IPs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:

> What the hell kind of monster are you making?  There's got to be another way.

heh. As I mentioned in my other response, we're doing TCP/IP load
balance testing--so we need one linux system to act as many hosts. The
only solution, short of using bind/connect/accept/etc with non-local
IPs, is to use raw sockets (libpcap+libnet) and handle all of the TCP
protocol layer in userland. For speed reasons, that's clearly not
desireable, so I am seeking a kernel solution for acting as many hosts
(10,000+) without having to bring up network interfaces for each one....

Kind of sick, isn't it? :) In any case we will definitely be pushing the
2.4 network code to the extreme.

Regards,

Bryan

-- 
Bryan Rittmeyer
mailto:bryan@ixiacom.com
Ixia Communications
26601 W. Agoura Rd.
Calabasas, CA 91302

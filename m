Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317126AbSFKPUe>; Tue, 11 Jun 2002 11:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317129AbSFKPUd>; Tue, 11 Jun 2002 11:20:33 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:60361 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S317126AbSFKPUc>; Tue, 11 Jun 2002 11:20:32 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793921@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: IP question
Date: Tue, 11 Jun 2002 11:20:30 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a cPCI machine running an embedded application. Communication with
other devices is done via UDP/IP. I am using my own two devices which
replace the standard eth0/eth1. I call them ifp0 and ifp1. My two IP
addresses are 10.1.1.4 and 10.1.1.5

The two Ethernet devices are connected to two physically separate LAN
switches which are part of one sub-net. I want to do an uplink test to
ensure that the two switches are connected. To acomplish this I send a test
message (sort of like a ping) from my 10.1.1.4 address to 10.1.1.5). 

I have the following route command prior to the send

route add -net 10.1.1.5 netmask 255.255.255.255 dev ifp0   /* I want to
route messages destined for 10.1.1.5 from 10.1.1.4 */

My sendto fails, yet when sending to other devices via the same socket it
all works. Only a send to my "other" internal IP address fails and it is
failing within the IP stack somehow.

Any clues?  Please CC me directly on any replies.

Thanks in advance.

Jack Bloch
Siemens Carrier Networks
e-mail    : jack.bloch@icn.siemens.com
phone     : (561) 923-6550


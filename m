Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267999AbRHBAX4>; Wed, 1 Aug 2001 20:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268003AbRHBAXh>; Wed, 1 Aug 2001 20:23:37 -0400
Received: from [212.113.174.249] ([212.113.174.249]:40739 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S267999AbRHBAXc> convert rfc822-to-8bit;
	Wed, 1 Aug 2001 20:23:32 -0400
From: =?iso-8859-1?Q?Andr=E9_Cruz?= <afafc@rnl.ist.utl.pt>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with interfaces and ioctl
Date: Thu, 2 Aug 2001 01:22:29 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAArqXyEnDnsk6P8VUX1zHRj8KAAAAQAAAAnxNb4bCQe0SgkiQW71IeZAEAAAAA@rnl.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2526.0000
X-OriginalArrivalTime: 02 Aug 2001 00:19:08.0986 (UTC) FILETIME=[BF73D9A0:01C11AE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems bringing down interfaces. Each time I use ioctl to
change the IFF_UP flag a zombie process is created.

I noticed that since I upgraded to 2.4 whenever we create an interface a
new process is created and it's PPID is the creating process. But when I
try to bring it down that process doesn't die and no sigchld is received
by it's PPID. What's worse is that when I bring that interface up again
a new process is created. 
Specifically I'm having problems using dhcpcd. After a few days this is
what I see with a ps:

 F   UID   PID  PPID PRI  NI   VSZ  RSS  WCHAN STAT TTY        TIME
COMMAND
140     0  3278     1   9   0   780  388 116c8e S    ?          0:05
/sbin/dhcpcd
044     0  7729  3278   9   0     0    0 11235d Z    ?          0:00  \_
[eth0 <defuct>]
044     0  7732  3278   9   0     0    0 11235d Z    ?          0:00  \_
[eth0 <defuct>]
044     0  8747  3278   9   0     0    0 11235d Z    ?          0:00  \_
[eth0 <defuct>]
040     0  8765  3278   9   0     0    0 16baad SW   ?          0:00  \_
[eth0]

What can I do about this? Is this not the right way to bring down an
interface?
Btw my current kernel is 2.4.7.

Thanks for the help.


----------
André Cruz


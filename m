Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284887AbRLRT5Y>; Tue, 18 Dec 2001 14:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284854AbRLRTz7>; Tue, 18 Dec 2001 14:55:59 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:22818 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S284848AbRLRTyr>; Tue, 18 Dec 2001 14:54:47 -0500
Date: Tue, 18 Dec 2001 18:52:30 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: <andre@linux-ide.org>
cc: Linux <linux-kernel@vger.kernel.org>
Subject: Delivery Status Notification (fwd)
Message-ID: <20011218184625.D1942-120000@gerard>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; REPORT-TYPE=delivery-status; BOUNDARY="=========3C19C63F000E165F/mail.libertysurf.net"
Content-ID: <20011218184625.O1942@gerard>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--=========3C19C63F000E165F/mail.libertysurf.net
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <20011218184625.V1942@gerard>



---------- Forwarded message ----------
Date: Tue, 18 Dec 2001 20:45:14 +0100
From: Mail Delivery Service <postmaster@libertysurf.fr>
To: groudier@free.fr
Subject: Delivery Status Notification

 - These recipients of your message have been processed by the mail server:

andre@linux-ide.org; Action: Failed; Status: 5.3.0 (other or undefined mail system status)
    Remote MTA mail.linux-ide.org: network error

 - SMTP protocol diagnostic: 550 <groudier@free.fr>... We don't accept mail from spammers


--=========3C19C63F000E165F/mail.libertysurf.net
Content-Type: MESSAGE/DELIVERY-STATUS; CHARSET=US-ASCII
Content-ID: <20011218184625.X1942@gerard>
Content-Description: 

Reporting-MTA: dns; mail.libertysurf.net
Received-from-MTA: dns; [192.168.1.129] (212.129.44.56)
Arrival-Date: Tue, 18 Dec 2001 20:44:42 +0100

Final-Recipient: rfc822; andre@linux-ide.org
Action: Failed
Status: 5.3.0 (other or undefined mail system status)
Remote-MTA: dns; mail.linux-ide.org

--=========3C19C63F000E165F/mail.libertysurf.net
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <20011218184625.V1942@gerard>
Content-Description: 

Return-Path: <groudier@free.fr>
Received: from [192.168.1.129] (212.129.44.56) by mail.libertysurf.net (5.1.053)
        id 3C19C63F000E165F; Tue, 18 Dec 2001 20:44:42 +0100
Date: Tue, 18 Dec 2001 18:42:49 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Andre Hedrick <andre@linux-ide.org>
cc: jlm <jsado@mediaone.net>,  <linux-kernel@vger.kernel.org>
Subject: Re: Poor performance during disk writes
In-Reply-To: <Pine.LNX.4.10.10112181043110.21250-100000@master.linux-ide.org>
Message-ID: <20011218183059.L1832-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Tue, 18 Dec 2001, Andre Hedrick wrote:

> File './Bonnie.2276', size: 1073741824, volumes: 1
> Writing with putc()...  done:  72692 kB/s  83.7 %CPU
> Rewriting...            done:  25355 kB/s  12.0 %CPU
> Writing intelligently...done: 103022 kB/s  40.5 %CPU
> Reading with getc()...  done:  37188 kB/s  67.5 %CPU
> Reading intelligently...done:  40809 kB/s  11.4 %CPU
> Seeker 2...Seeker 1...Seeker 3...start 'em...done...done...done...
>               ---Sequential Output (nosync)--- ---Sequential Input-- --Rn=
d Seek-
>               -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04=
k (03)-
> Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /s=
ec %CPU
>        1*1024 72692 83.7 103022 40.5 25355 12.0 37188 67.5 40809 11.4  38=
2.1  2.4
>
> Maybe this is the kind of performance you want out your ATA subsystem.
> Maybe if I could get a patch in to the kernels we could all have stable
> and fast IO.

I rather see lots of wasting rather than performance, here. Bonnie says
that your subsystem can sustain 103 MB/s write but only 41 MB/s read. This
looks about 60% throughput wasted for read.

Note that if you intend to use it only for write-only applications,
performance are not that bad, even if just dropping the data on the floor
would give you infinite throughput without any difference in
functionnality. :-)


G=E9rard Roudier
Not CEO, not President of anything.

> Regards,
>
>
> Andre Hedrick
> CEO/President, LAD Storage Consulting Group
> Linux ATA Development
> Linux Disk Certification Project


--=========3C19C63F000E165F/mail.libertysurf.net--

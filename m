Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281521AbRKMMfj>; Tue, 13 Nov 2001 07:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281526AbRKMMf3>; Tue, 13 Nov 2001 07:35:29 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:24839 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S281521AbRKMMfR>; Tue, 13 Nov 2001 07:35:17 -0500
Message-ID: <3BF1138B.82B0FEED@loewe-komp.de>
Date: Tue, 13 Nov 2001 13:35:23 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: william fitzgerald <william.fitzgerald3@beer.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: printk performance logging without syslogd for router
In-Reply-To: <E2D08E27D008FC940A0E24ADA76AD89F@william.fitzgerald3.beer.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

william fitzgerald wrote:
> 
> ---- Begin Original Message ----
>  From: Peter Wächtler <pwaechtler@loewe-komp.de>
> Sent: Tue, 13 Nov 2001 13:15:45 +0100
> To: william fitzgerald
> <william.fitzgerald3@beer.com>
> CC: linux-kernel@vger.kernel.org
> Subject: Re: printk performance logging without
> syslogd for router
> 
> william fitzgerald wrote:
> >
> > hi all,
> >
> > (perforamnce logging of network stack through a
> > linux router)
> >
> > the main question:
> >
> > is there a way i can buffer or record  the
> printk
> > statements and print them to disk  after my
> > packets have gone through the router?
> >
> 
> there is an option in syslogd to prevent
> immediatly
> writing to the logfile:
> 
> prefix the log with a dash:
> 
> kern.*  -/var/log/kernelmessages
> 
> ---- End Original Message ----
> 
> what does klogd do?
> 
> i thought klogd writes to disk if you turn off
> syslogd.that way you only have one over head.
> 

OK, normally klogd pushes the messages to syslog.
Then syslogd decides where and how to write to disk.

If you use "klogd -f /tmp/logfile" I don't know how
to prevent immediate write()s to disk. The source code
of klogd will tell you :-)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbTIQJlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 05:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTIQJlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 05:41:19 -0400
Received: from [203.124.210.99] ([203.124.210.99]:39886 "EHLO
	rocklines.oyeindia.com") by vger.kernel.org with ESMTP
	id S261883AbTIQJlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 05:41:16 -0400
From: "msrinath" <msrinath@bplitl.com>
To: "'Richard J Moore'" <rasman@uk.ibm.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Re: Kernel NMI error
Date: Wed, 17 Sep 2003 15:14:58 +0530
Message-ID: <007b01c37d00$5c696970$1d03000a@srinath>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <200309161624.04602.rasman@uk.ibm.com>
X-Information: Please contact the ISP for more information
X-Kaspersky: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for the reply.

I went through the syslog and did not find any kernel related error
messages.

I don't know much about power saving mode. We have not done anything
specific to enable/disable power saving mode or System Management mode.

I am not aware of crash dumps. Please let me know how to get it.

Thanks & Regards
- Srinath

-----Original Message-----
From: Richard J Moore [mailto:rasman@uk.ibm.com]
Sent: 16 September 2003 21:54
To: msrinath
Cc: Linux Kernel Mailing List
Subject: Fwd: Re: Kernel NMI error


NMI can occur for a number fo reasons:

I/O check from a card
Parity error from memory
DMA timeout
Watchdog timer expiry
INT 2  instruction

To investigate this further you need to look back though your Syslog for any
messages that might indicate intmittant h/w related errors or watchdog
reports.

One way to cause an intermittent NMI is by having power management enabled
with devices that don't support it. They see the world caving in when power
goes away and sometimes generate an NMI. If you're in a power saving process
then you have probably switched to System Management Mode, in which case the
NMI will be held pending the processor returning from SMM.

Do you have a crash dump associtated with this problem?

--
Richard J Moore
IBM Linux Technology Centre

On Tue 16 September 2003 11:38 am, msrinath wrote:
> Hello Everybody,
>
> Can anyone help me on this?
>
> Recently one of our servers running RedHat linux 7.2 with 2.4.7-10 SMP
> kernel generated the following log and the system rebooted. This system
has
> 2 CPUs.
>
> Sep 16 01:34:24 cbesc ftpd[30753]: FTP LOGIN FROM 16.128.157.7
> [16.128.157.7], scuser
> Sep 16 01:36:48 cbesc ftpd[30753]: FTP session closed
> Sep 16 01:54:30 cbesc kernel: Uhhuh. NMI received for unknown reason 35.
> Sep 16 01:54:30 cbesc kernel: Dazed and confused, but trying to continue
> Sep 16 01:54:30 cbesc kernel: Do you have a strange power saving mode
> enabled?
> Sep 16 01:54:30 cbesc kernel: eth0: card reports no resources.
> Sep 16 01:58:09 cbesc syslogd 1.4.1: restart.
> Sep 16 01:58:09 cbesc syslog: syslogd startup succeeded
>
> This is the first time we have faced this problem. The ethernet card used
> is intel eepro 100. The details are shown below.
>
> Sep 16 07:33:53 cbesc kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
> http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
> Sep 16 07:33:53 cbesc kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17
> Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
> Sep 16 07:33:53 cbesc kernel: eth0: Intel Corporation 82557 [Ethernet Pro
> 100], 00:A0:C9:A0:B7:71, IRQ 16.
> Sep 16 07:33:53 cbesc kernel:   Receiver lock-up bug exists -- enabling
> work-around.
> Sep 16 07:33:53 cbesc kernel:   Board assembly 668081-004, Physical
> connectors present: RJ45
> Sep 16 07:33:53 cbesc kernel:   Primary interface chip i82555 PHY #1.
> Sep 16 07:33:54 cbesc kernel:   General self-test: passed.
> Sep 16 07:33:54 cbesc kernel:   Serial sub-system self-test: passed.
> Sep 16 07:33:54 cbesc kernel:   Internal registers self-test: passed.
> Sep 16 07:33:54 cbesc kernel:   ROM checksum self-test: passed
> (0x3c15c8f1). Sep 16 07:33:54 cbesc kernel:   Receiver lock-up workaround
> activated.
>
>
> Please let me know why this happened and whether it indicates any hardware
> problem in the system.
>
> Please send a CC to my email address, since I have not subscribed to the
> list.
>
> Thanks & Regards,
>
> - Srinath.

-------------------------------------------------------

--
Richard J Moore
IBM Linux Technology Centre

--
This message has been scanned for viruses and
dangerous content by Kaspersky on bpl Server, and is
believed to be clean.
bpl www.kaspersky.com
.


-- 
This message has been scanned for viruses and
dangerous content by Kaspersky on bpl Server, and is
believed to be clean.
bpl www.kaspersky.com
.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVAMQPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVAMQPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVAMQJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:09:10 -0500
Received: from mail108.messagelabs.com ([216.82.255.115]:1949 "HELO
	mail108.messagelabs.com") by vger.kernel.org with SMTP
	id S261663AbVAMQDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:03:02 -0500
X-VirusChecked: Checked
X-Env-Sender: AAnthony@sbs.com
X-Msg-Ref: server-5.tower-108.messagelabs.com!1105632179!7446850!1
X-StarScan-Version: 5.4.5; banners=sbs.com,-,-
X-Originating-IP: [204.255.71.6]
Message-ID: <4F23E557A0317D45864097982DE907941A38A8@pilotmail.sbscorp.sbs.com>
From: Adam Anthony <AAnthony@sbs.com>
To: khc@pm.waw.pl, Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Linux HDLC Stack - N2 module
Date: Thu, 13 Jan 2005 09:02:20 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof and Ueimor,
	Following the advice prescribed below, I've had a look at existing
HDLC work in the kernel.  I tried firing up a Riscom/N2 adapter with the
2.4.28 N2 module and HDLC support but was faced with a number of problems.
It seems like the transmit buffers aren't getting emptied after transmit,
because I can only transmit a few frames before traffic halts.  Transmit
statistics don't increment either, but I am seeing frames on the remote end.
	Has the N2 module been tested with recent kernels?  Is it useable?
If not, which module will show me the genius of the Linux HDLC "stack"?
-AA

-----Original Message-----
From: Francois Romieu [mailto:romieu@fr.zoreil.com] 
Sent: Monday, January 10, 2005 1:01 PM
To: Adam Anthony
Cc: netdev@oss.sgi.com; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /driver/net/wan/sbs520

Adam Anthony <AAnthony@sbs.com> :
[...]
>        It would be great to receive some feedback on our work, and we hope
> that this driver will eventually be added to the kernel.

It will probably require a few extra steps:
- read Documentation/CodingStyle (mixed case, typedef from hell, ugly
#ifdef);
- grep ^static
  -> no static functions ? Uh ?
- use non-obsolete API (pci_find_device in 2005 ?);
- convert the os independant wrappers.

Btw it would probably make sense 1) to figure out what can be merged with
the in-tree DSCC4 driver and 2) to integrate the driver with the existing
hdlc stack. Imho there is some duplicated work/code.

--
Ueimor

***This message has been scanned for virus, spam, and undesirable
content.***
***For further information, contact your mail administrator.***

For limitations on the use and distribution of this message, please visit www.sbs.com/emaildisclaimer.

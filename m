Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTF0Lmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 07:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTF0Lmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 07:42:54 -0400
Received: from mail.atr.bydgoszcz.pl ([212.122.192.35]:46792 "EHLO
	mail.atr.bydgoszcz.pl") by vger.kernel.org with ESMTP
	id S264208AbTF0Lms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 07:42:48 -0400
From: "adamski" <adam_lista_linux@poczta.onet.pl>
To: "Robert Olsson" <Robert.Olsson@data.slu.se>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: RE: How to do kernel packet forwarding performance analysys - please comment on my method 
Date: Fri, 27 Jun 2003 13:56:23 +0200
Message-ID: <GMEGLMHAELFDACHHIEPICEBPCFAA.adam_lista_linux@poczta.onet.pl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <16124.11592.136156.61126@robur.slu.se>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4925.2800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree the term forwarding is vague - this is problably my english
imprecission...

I mean timing the whole packet path:
 strating from irq handing through putting into backlog, picking from
backlog, handling packet to higher layers (3), dealing with packet header
processing (CRC, TTL etc), lookup, classification (for output queueing),
forwarding, puting packet to output queue, tx_queue, and hard_dev_xmit et
least....


this is what I would like to measure/benchmark (sorry my imprecise english
usage).

I would like to see how packet size influences certain operations (as
mentioned earlier) etc....
let's say having as the output the functions called with its timings ...

i would like to start two flows through linux router: PHB EF and BE PHB..
like voip and ftp or so...

than i want to analyse what exactly happens ... since my theoretical
analysys show delays (or latencies - from packet entering the NIC to going
out of the outgoing interface) of hundereds of usec (~200us) while
experiments shows 5-10ms !!!!! with CBQ (configured like CBWFQ and LLQ)

this is it

any help welcomed


regards

adam


-----Original Message-----
From: linux-net-owner@vger.kernel.org
[mailto:linux-net-owner@vger.kernel.org]On Behalf Of Robert Olsson
Sent: Friday, June 27, 2003 1:41 PM
To: Adam Flizikowski
Cc: linux-kernel@vger.kernel.org; linux-net@vger.kernel.org
Subject: How to do kernel packet forwarding performance analysys - please
comment on my method



Adam Flizikowski writes:
 >
 > Hello,
 >
 > I want to analyze how much time is spent on forwarding process in linux
 > kernel.
 >
 > This is second post but the matter is very important to me. I am dealing
 > with this for few months now.

 Hello!
 "time spent on forwarding" is very vague. Raw forwarding capacity use
 to be measured in pps (packets per second) and it depends on many things
 beside hardware as packet size, routing table size, new flows/s etc.

 You can look at (o)profiles during forwarding.

 Cheers.
						--ro
-
To unsubscribe from this list: send the line "unsubscribe linux-net" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


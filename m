Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWGQIpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWGQIpB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 04:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWGQIpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 04:45:01 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:43921 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP
	id S1750756AbWGQIpA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 04:45:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Very long startup time for a new thread
Date: Mon, 17 Jul 2006 10:44:58 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668038E9BBF@exmail1.se.axis.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Very long startup time for a new thread
Thread-Index: AcamQqWIuEPGSDpkRmWmQFFDF8k/ZQDOoEXw
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "Mikael Starvik" <mikael.starvik@axis.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Jul 2006 08:44:58.0869 (UTC) FILETIME=[4913FA50:01C6A97D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all that have made suggestions. Finnaly we found that 

#define MIN_TIMESLICE 5
#define DEF_TIMESLICE 25

works much better for us. Maybe it is an effect of that we have HZ=100 ?

/Mikael

-----Original Message-----
From: Mikael Starvik [mailto:mikael.starvik@axis.com] 
Sent: Thursday, July 13, 2006 8:08 AM
To: 'Linux Kernel Mailing List'
Subject: Very long startup time for a new thread


(This is on a 200 MIPS embedded architecture).

On a heavily loaded system (loadavg ~4) I create a new pthread. In this
situation it takes ~4 seconds (!) before the thread is first scheduled
in (yes, I have debug outputs in the scheduler to check that). In a 2.4
based system I don't see the same thing. I don't have any RT or FIFO
tasks. Any ideas why it takes so long time and what I can do about it?

Appreciate any help
/Mikael

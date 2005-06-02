Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVFBBRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVFBBRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVFBBRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:17:18 -0400
Received: from dream.eng.uci.edu ([128.195.164.137]:63844 "EHLO
	dream.dream.eng.uci.edu") by vger.kernel.org with ESMTP
	id S261524AbVFBBOO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:14:14 -0400
From: "Liangchen Zheng" <zlc@dream.eng.uci.edu>
To: "'Arjan van de Ven'" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: The values of gettimeofday() jumps.
Date: Wed, 1 Jun 2005 18:18:31 -0700
Message-ID: <006f01c56710$fd604690$85a4c380@dream.eng.uci.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <1117352538.6278.0.camel@laptopd505.fenrus.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-OriginalArrivalTime: 02 Jun 2005 01:18:37.0093 (UTC) FILETIME=[0087C550:01C56711]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The clock drift disappeared after booting the kernel with
"notsc" option.
Thanks a lot.  It seems there is some bug with the TSC support inside
the kernel.
Maybe it is caused by the clock drifts between two TSCs in the both
CPUs, as mentioned by Pádraig Brady in one reply to my previous
question.  
	But I am still wondering why the clock drift can be so huge (a
couple of seconds sometimes) and the drifts occurred so regular (around
every 1 second).
If I have time in future, I will dig into it to figure out what is the
exact reason.
	Thanks a lot for your suggestions.

Regards,
Liangchen

-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org] 
Sent: Sunday, May 29, 2005 12:42 AM
To: Liangchen Zheng
Cc: linux-kernel@vger.kernel.org
Subject: Re: The values of gettimeofday() jumps.

On Sat, 2005-05-28 at 18:37 -0700, Liangchen Zheng wrote:
> Hello,
> 	We have several SMP machines (Tyan Tiger MPX motherboard, 2
> AthlonMP 1900+ CPU, linux-2.4.21-20.EL).  When running some time
> sensitive programs, I observed that the values of gettimeofday ()
jumped
> sometimes on a couple of machines (other machines are fine), from
> several hundreds milliseconds to a couple of seconds. 

try "notsc" as boot option



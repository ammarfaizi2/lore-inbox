Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbVAFQjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVAFQjx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVAFQjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:39:53 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:22675 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262906AbVAFQjt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:39:49 -0500
X-Ironport-AV: i="3.88,107,1102312800"; 
   d="scan'208"; a="158519250:sNHT24068596"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6.10-bk8] [SERIAL] dropping chars when > 512
Date: Thu, 6 Jan 2005 10:39:47 -0600
Message-ID: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D30@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.10-bk8] [SERIAL] dropping chars when > 512
Thread-Index: AcT0B1fheGmVBojXSGagZXKBGykyvgAAYzag
From: <Tim_T_Murphy@Dell.com>
To: <stuartm@connecttech.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Jan 2005 16:39:48.0122 (UTC) FILETIME=[55E83FA0:01C4F40E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unless this is a typo, I think you'll find that status = 1 means the
> FIFOs have been turned off. Which would flush any data in the FIFOs.
> Which would explain the missing data.
> 
> ..Stu

Nope, not a typo.
I'm no expert, but i thought 'status' shows the LSR when an interrupt
occurs, and LSR = 1 indicates 'data available', while LSR = 60 indicates
transmitter status (40 = THR empty, 20 = THR + shift register empty)?
so status = 1 indicates an interrupt occurs while transmitter is busy?

I think this is related to tty flip buffer full (size = 512), and no
low_latency setting (which, if set, hangs the 2.6 SMP kernel).  but i'm
not expert enough with serial to know a fix.
thanks,
tim

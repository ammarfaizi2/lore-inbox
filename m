Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSFGKwe>; Fri, 7 Jun 2002 06:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSFGKwd>; Fri, 7 Jun 2002 06:52:33 -0400
Received: from gateway.jabil.com ([198.51.174.14]:34945 "HELO
	corrly01.jabil.com") by vger.kernel.org with SMTP
	id <S316757AbSFGKwc>; Fri, 7 Jun 2002 06:52:32 -0400
X-Server-Uuid: 492ed892-c84e-11d3-bc9a-0008c7b13976
Message-ID: <86D0D7E1B6BA1049B4D0FDAE456354E3016F03A5@livmsgn10b>
From: "Andrew Potter" <Andrew_Potter@Jabil.com>
To: "'andre@linux-ide.org'" <andre@linux-ide.org>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: BUG: cmd64x.c - CFR_INTR_CH0 - Kernel 2.4.x
Date: Fri, 7 Jun 2002 06:52:33 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 111E4F04667138-01-02
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

	It might just be me but I think there is an error within the defines
of the cmd64x.c driver file.

	Looking through the specs for the cmd643 and cmd646 ( my laptop uses
both chips, primary channels only and doesn't play very well with kernel
2.4.x at the moment ) , they show that the configuration register (0x50) is
using bit 2 for channel 0 interrupt status (CFR_INTR_CH0).

	The source specifies this as 0x02, should this not be 0x04 ?

Regards

	Andy - Learning Linux 1 day at a time


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136614AbREAOAF>; Tue, 1 May 2001 10:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136616AbREAN74>; Tue, 1 May 2001 09:59:56 -0400
Received: from smtp102.urscorp.com ([38.202.96.105]:6416 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S136614AbREAN7l>; Tue, 1 May 2001 09:59:41 -0400
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: isa_read/write not available on ppc - solution suggestions ??
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OFED368CB7.D5C74726-ON85256A3F.004547C6@urscorp.com>
Date: Tue, 1 May 2001 09:52:30 -0400
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 05/01/2001 09:55:26 AM,
	Serialize complete at 05/01/2001 09:55:26 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To get the pcmcia ibmtr driver (ibmtr/ibmtr_cs) working on ppc, all the 
isa_read/write's have to be changed to regular read/write due to the lack 
of the isa_read/write functions for ppc.

So, the question is should I simply:

a) change everything to read/write and friends (the way the driver used to 
be before the isa_read/write function were introduced)
b) Put ugly macros in the driver to use the different functions depending 
upon architecture.
c) Implement the isa_read/write functions for ppc ? 
or d) something completely different I haven't thought of. 

Remember, this driver must support isa, pcmcia, mca, ix86 and now ppc. 

Personally I'd rather not have arch dependent macros in the driver, but I 
know there is a good reason why the isa_read/write functions were 
introduced in the first place. 

Suggestions ?

Mike
Linux Token Ring Project
http://www.linuxtr.net

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273872AbRI0UJp>; Thu, 27 Sep 2001 16:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273855AbRI0UJe>; Thu, 27 Sep 2001 16:09:34 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16515 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S273872AbRI0UJW>;
	Thu, 27 Sep 2001 16:09:22 -0400
Importance: Normal
Subject: Re: Pentium SSE prefetcht0 instruction... How do you make it work
To: Tony Hagale <tony@hagale.net>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF1BD9092B.AC76CE4D-ON85256AD4.006E6555@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Thu, 27 Sep 2001 16:09:43 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/27/2001 04:08:25 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>Intel's p3/4 prefetch instructions are hints only. They are only executed
>asynchronously, and depend heavily on the other load on the processor at
>the time. They are not required to prefetch, *and* they are not required
>to be executed when you think they should in the flow of the program. You
>can serialize them by using an MFENCE instruction, but they still aren't
>guaranteed to run.
>
>Check the p4 manuals. In fact, I'm not sure prefetch was implemented in
>p3. I could be wrong, check the manual.
>
>--Tony
PREFETCHx are in P3. I am aware that processor executes them optionally.
MFENCE may be a good idea.  If load/store queues are full the processor
may just drop the prefetch instruction.  I should try this.
Thanks for the suggestion.  /bulent




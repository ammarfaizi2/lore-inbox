Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317934AbSGKXHj>; Thu, 11 Jul 2002 19:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317933AbSGKXHi>; Thu, 11 Jul 2002 19:07:38 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:40071 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S317932AbSGKXHg>; Thu, 11 Jul 2002 19:07:36 -0400
Subject: Re: [STATUS 2.5]  July 10, 2002
To: Thunder from the hill <thunder@ngforever.de>
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       <linux-kernel@vger.kernel.org>,
       Larry_Kessler/Beaverton/IBM%IBMGB <Larry_Kessler/Beaverton/IBM@uk.ibm.com>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFECA8B235.6959642F-ON85256BF3.006A387F@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Thu, 11 Jul 2002 21:34:37 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 12/07/2002 00:10:16
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Are there any reasons why these don't make it into 2.5?
>>
>> >    - Better event logging for enterprise systems
>
> Linus was scared we could break old syslog parsers.

This is a surprising view given that what we currently have is broken.
Logging serves two purposes:
problem determination - via a human interface
system's management - via automation
It's the latter we need to be able to do reliably and can't because
currently:

   message uniqueness is not guaranteed
   message content is not complete for automation purposes
   some of the most serious error message have the least useful content
   many messages are issued using multiple printks and on an MP system can
   have their text interleaved
   there's no national language support
   embedded systems are not well catered for
   message recognition and parsing is haphazard

EVL is not seeking to do a wholesale replacement of printk. But does
provide the necessary infrastructure to achieve automation. Instrumentation
and re-instrumentation is an independent activity. It can be done in
incremental steps. But until we have a useful log management system service
we can't even begin to address the needs of system automation and systems'
management.

Again the OLS RAS BoF discussions were very focused on this issue and
supportive of it.  Instrumentation was the key subject of discussion - how
to do it with no administrative overhead, how to do it in a way that
developers would find acceptable, how to satisfy the needs for NLS and
embedded systems.

Richard J Moore IBM Linux Technology Centre


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWFBGT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWFBGT4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFBGT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:19:56 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:63138 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1751100AbWFBGTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:19:55 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.0.166):SA:0(-102.3/1.7):. Processed in 1.967608 secs Process 23469)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: "Paulo Marques" <pmarques@grupopie.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Page Allocation Failure, Why?? Bug in kernel??
Date: Fri, 2 Jun 2006 11:56:49 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMGEJJCNAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <447F00C7.4060904@mbligh.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

That's precisely I want to say. The PAGES are available but they are not
allocated to process. Why??

~Abu.

-----Original Message-----
From: Martin J. Bligh [mailto:mbligh@mbligh.org]
Sent: Thursday, June 01, 2006 8:29 PM
To: Abu M. Muttalib
Cc: Paulo Marques; linux-kernel@vger.kernel.org
Subject: Re: Page Allocation Failure, Why?? Bug in kernel??


Abu M. Muttalib wrote:
> Hi,
>
> I am sorry to cause inconvenience. To put the doubts concisely, I am doing
> the following:
>
> I am removing the sound driver (shipped with kernel 2.6.13) and then
> inserting the same. This all I am doing inside an infinite loop. Before
this
> I have reserved and used (setting the same with memset) some 900 pages to
> simulate an application environment. I am running this application on
Linux
> 2.6.13 on an ARM based target. During the course of the run I get the
> following page allocation error:
> --------------------------------------------------------------------------
--
> ---------------------------------------------------------------insmod:
page
> allocation failure. order:5, mode:0xd0

Order 5 allocations will never work reliably, except possibly at boot.
We don't have 32 contig pages to give you - fragmentation.

M.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWGMHvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWGMHvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWGMHvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:51:23 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:53951 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S964837AbWGMHvW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:51:22 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Very long startup time for a new thread
Date: Thu, 13 Jul 2006 09:51:09 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668030B55B4@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66803F33440@exmail1.se.axis.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope, no NPTL. Actually this system uses the pthread implementation in
uC-libc.

-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org] 
Sent: Thursday, July 13, 2006 9:15 AM
To: Mikael Starvik
Cc: 'Linux Kernel Mailing List'
Subject: Re: Very long startup time for a new thread


On Thu, 2006-07-13 at 08:07 +0200, Mikael Starvik wrote:
> (This is on a 200 MIPS embedded architecture).
> 
> On a heavily loaded system (loadavg ~4) I create a new pthread. In this
> situation it takes ~4 seconds (!) before the thread is first scheduled in
> (yes, I have debug outputs in the scheduler to check that). In a 2.4 based
> system I don't see the same thing. I don't have any RT or FIFO tasks. Any
> ideas why it takes so long time and what I can do about it?

I assume you're using a new enough glibc that supports NPTL ?


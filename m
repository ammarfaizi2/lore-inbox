Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWAZDbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWAZDbA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWAZDbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:31:00 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:58130 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751305AbWAZDa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:30:59 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <lkml@rtr.ca>
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "Christopher Friesen" <cfriesen@nortel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <hancockr@shaw.ca>
Subject: RE: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Wed, 25 Jan 2006 19:30:42 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEJPJKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <43D8386B.6000204@rtr.ca>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 25 Jan 2006 19:27:32 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 25 Jan 2006 19:27:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 	So you cannot write an application that can tell the difference.

> Not true.  The code for the relinquishing thread could indeed
> tell the difference.
>
> -ml

	It can tell the difference between the other thread getting the mutex first
and it getting the mutex first. But it cannot tell the difference between an
implementation that puts random sleeps before calls to 'pthread_mutex_lock'
and an implementation that has the allegedly non-compliant behavior. That
makes the behavior compliant under the 'as-if' rule.

	If you don't believe me, try to write a program that prints 'non-compliant'
on a system that has the alleged non-compliance but is guaranteed not to do
so on any compliant system. It cannot be done.

	In order to claim the alleged compliance, you would have to know that a
thread waiting for a mutex did not get it. But there is no possible way you
can know that another thread is waiting for the mutex (as opposed to being
about to wait for it). So you can never detect the claimed non-compliance,
so it's not non-compliance.

	This is definitive, really. It 100% refutes the claim.

	DS



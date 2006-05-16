Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWEPCri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWEPCri (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 22:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWEPCri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 22:47:38 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:43015 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751087AbWEPCrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 22:47:37 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: send(), sendmsg(), sendto() not thread-safe
Date: Mon, 15 May 2006 19:47:03 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEPCLOAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <OFE8460E54.0C8D85D8-ON8525716F.0074F22F-8825716F.0076D537@us.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 15 May 2006 19:42:56 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 15 May 2006 19:42:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I discovered that in some cases, send(), sendmsg(), and sendto() are not
> thread-safe. Although the man page for these functions does not specify
> whether these functions are supposed to be thread-safe, my reading of the
> POSIX/SUSv3 specification tells me that they should be. I traced the
> problem to tcp_sendmsg(). I was very curious about this issue, so I wrote
> up a small page to describe in more detail my findings. You can 
> find it at:
> http://www.almaden.ibm.com/cs/people/marksmith/sendmsg.html .
> 
> Thanks,
> Mark A. Smith

	You are confusing thread-safety with atomicity.

	DS



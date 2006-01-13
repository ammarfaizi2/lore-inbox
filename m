Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423069AbWAMWwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423069AbWAMWwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423070AbWAMWwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:52:16 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:50699 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1423069AbWAMWwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:52:15 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: epoll_wait, epoll_ctl
Date: Fri, 13 Jan 2006 14:51:10 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEPAJFAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <43C7AD5A.2000700@symas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 13 Jan 2006 14:48:05 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 13 Jan 2006 14:48:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, what's supposed to happen in a threaded program where one thread
> does an epoll_ctl on an epoll fd while another thread is currently
> waiting in epoll_wait on the same fd?

	Nothing special.

> In particular, what happens if a
> thread does an EPOLL_CTL_DEL on one of the fds that is currently being
> waited on? Is there a possibility of an event being returned on the fd
> even after the EPOLL_CTL_DEL completes?

	Absolutely. The EPOLL_CTL_DEL might not even start until after the event
has been determined to be returned and the wait is in the process of
returning.

	DS



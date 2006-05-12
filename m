Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWELF1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWELF1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 01:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWELF1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 01:27:41 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:38156 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750895AbWELF1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 01:27:41 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Linux poll() <sigh> again
Date: Thu, 11 May 2006 22:26:44 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEJGLNAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.61.0605111023030.3729@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 11 May 2006 22:22:38 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 11 May 2006 22:22:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have used the subsequent read() with a returned
> value of zero, to indicate that the client disconnected
> (as a work around). However, on recent versions of
> Linux, this is not reliable and the read() may
> wait forever instead of immediately returning.

	If a 'read' on a non-blocking socket is waiting, something is seriously
wrong that goes way beyond 'poll'. If you're using a blocking socket, well,
blocking sockets block, 'poll' notwithstanding.

	DS



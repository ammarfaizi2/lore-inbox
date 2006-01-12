Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWALBeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWALBeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWALBeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:34:31 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:31758 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S964959AbWALBe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:34:28 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Ian Campbell" <ijc@hellion.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: OT: fork(): parent or child should run first?
Date: Wed, 11 Jan 2006 17:33:13 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMECAJFAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1136987743.6547.122.camel@tara.firmix.at>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 11 Jan 2006 17:30:07 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 11 Jan 2006 17:30:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Yes.
> But ATM the signal handler calls waitpid() and stores the pid in a
> to-be-cleaned-pids array (at time X).
> The main loop at some time in the future (say at time X+N) walks through
> the to-be-cleaned-pids array and cleans them from the active-childs
> array.

	Obviously that's broken. You would have precisely the same problem if you
did the same thing with file descriptors or sockets.

	DS



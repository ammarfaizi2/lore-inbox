Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268993AbUJQAcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268993AbUJQAcr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUJQAcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:32:46 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:61448 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S268987AbUJQAad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:30:33 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sat, 16 Oct 2004 17:30:23 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEOOPAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20041017000626.GA27055@mark.mielke.cc>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 16 Oct 2004 17:07:03 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 16 Oct 2004 17:07:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't think he is, but if he is:
>
> I'm not sure that either is reasonable behaviour. The socket buffers
> don't increase or decrease at run time, do they? If they do shrink at
> run time, this is news to me...

	The socket buffers are not guaranteed to indicate a particular number of
bytes in a sense that it meaningful to the application. In fact, on Linux,
they don't mean application bytes.

	In any event, we aren't talking about any particular implementation, we are
talking about a standard. So what Linux does or doesn't do in response to
memory pressure isn't relevant. What's relevant is what the standard
actually guarantees and what the semantics of the protocols themselves are.

	UDP is not reliable. Packets can be dropped, mangled, and lost. Nothing in
POSIX prohibits an implementation from dropping a packet right before you
call 'recvmsg'.

	DS



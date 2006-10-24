Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbWJXMBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWJXMBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWJXMBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:01:04 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:4515 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030364AbWJXMBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:01:02 -0400
Date: Tue, 24 Oct 2006 13:59:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Zan Lynx <zlynx@acm.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Giridhar Pemmasani <pgiri@yahoo.com>
Subject: Re: incorrect taint of ndiswrapper
In-Reply-To: <1161628581.8901.30.camel@localhost>
Message-ID: <Pine.LNX.4.61.0610241354280.11608@yvahk01.tjqt.qr>
References: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com> 
 <1161600064.19388.14.camel@localhost.localdomain> <1161628581.8901.30.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The kernel itself links GPL code to non-GPL via the Posix API (the
>syscall layer).  The kernel also links GPL code to non-GPL via the PCI
>layer (all that proprietary firmware on the other side).  The
>ndiswrapper links GPL code to non-GPL via the NDIS API.
>
>No difference, really.

Behind the syscall layer is userspace (the well known ring 3), which, all bugs
and problems aside, and exceptions like ioperm ruled out, cannot crash the
kernel.

I am not too aware about firmware and how it affects the running kernel, but
usually it is a binary blob that gets loaded into the PCI device. May or may
not crash the kernel - as said, I am not too aware of how it can tamper with
the kernel.

NDIS code however is, unlike the above, run unconditionally in superprivileged
level (ring 0), which quite distinct from userspace or firmwarespace[note
warning above].

Lastly, there is the new IIO code, which sounds like it is a well-defined (you
name it) interface, to userspace however.

If Windows drivers could run in userspace, there would not be a problem, would
there be?

>  Implementing a well-defined interface
>abstraction layer doesn't make either side of it derived from the other.
>(Exactly how well-defined, how abstract, and how derived are all
>arguments for the lawyers.)
>-- 
>Zan Lynx <zlynx@acm.org>
>

	-`J'
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbTEIEAf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 00:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbTEIEAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 00:00:35 -0400
Received: from webmail.netapps.org ([12.162.17.40]:62687 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262287AbTEIEAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 00:00:34 -0400
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
References: <3EBAD63C.4070808@nortelnetworks.com>
	<20030509001339.GQ8978@holomorphy.com>
	<Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com>
	<20030509003825.GR8978@holomorphy.com>
	<Pine.LNX.4.53.0305082052160.21290@chaos>
	<3EBB25FD.7060809@nortelnetworks.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 08 May 2003 21:13:09 -0700
In-Reply-To: <3EBB25FD.7060809@nortelnetworks.com>
Message-ID: <52k7d0lpuy.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 May 2003 04:13:11.0561 (UTC) FILETIME=[4DEB7F90:01C315E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Chris> I want to find an additional programmable interrupt source.
    Chris> It bites that cheap PCs have this, and the powerpc doesn't.

I don't know which PowerPC CPU you are using, but for example the IBM
4xx series (and all Book E processors) have a "fixed interval timer"
interrupt that is currently not used at all by Linux.  (The
"programmable interval timer" is used to increment jiffies)

On something like the Motorola 74xx, you might be able to use the
something like the performance monitor to generate an exception.

Best,
  Roland

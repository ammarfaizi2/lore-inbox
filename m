Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUJAUPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUJAUPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUJAUPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:15:22 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:59666 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S266459AbUJAUNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:13:52 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Paul Fulghum'" <paulkf@microgate.com>
Cc: "'Russell King'" <rmk+lkml@arm.linux.org.uk>,
       "=?iso-8859-1?Q?'Roland_Ca=DFebohm'?=" 
	<roland.cassebohm@VisionSystems.de>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Serial driver hangs
Date: Fri, 1 Oct 2004 16:13:30 -0400
Organization: Connect Tech Inc.
Message-ID: <010101c4a7f3$1ef63540$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <1096575030.19487.50.camel@localhost.localdomain>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org 
> flush_to_ldisc was ok, then someone added the low latency
> flag. In the current 2.6.9rc3 patch flush_to_ldisc honours
> TTY_DONT_FLIP also

I've come late to this discussion. Not sure what the scope of this
cleanup is, but I'd like to see the flip buffers done away with
entirely, to be replaced by a single buffer with proper r/w locking.
Or keep the flip arrangement, but move it out of tty_struct so that it
can be made larger. Some of our high speed products find the rx buffer
to be less than sufficient.

..Stu


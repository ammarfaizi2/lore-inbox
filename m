Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTFDHjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 03:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTFDHjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 03:39:07 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:1520 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263062AbTFDHjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 03:39:06 -0400
Date: Wed, 4 Jun 2003 00:53:02 -0700
From: Andrew Morton <akpm@digeo.com>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: linux-yoann@ifrance.com, linux-kernel@vger.kernel.org, vojtech@suse.cz,
       acahalan@cs.uml.edu
Subject: Re: another must-fix: major PS/2 mouse problem
Message-Id: <20030604005302.41f3b0b8.akpm@digeo.com>
In-Reply-To: <20030604094737.C5345@ucw.cz>
References: <1054431962.22103.744.camel@cube>
	<3EDD87FD.6020307@ifrance.com>
	<20030603232155.1488c02f.akpm@digeo.com>
	<20030604094737.C5345@ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2003 07:52:35.0843 (UTC) FILETIME=[432F0530:01C32A6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@ucw.cz> wrote:
>
> On Tue, Jun 03, 2003 at 11:21:55PM -0700, Andrew Morton wrote:
> 
> > We believe that it may be due to the ethernet driver holding interrupts off
> > for too long when the traffic is heavy.
> 
> Note that this doesn't necessarily mean that the ethernet driver
> disables the interrupts for a too long time, it just means that the
> computer is only servicing the network interrupts at that time, and
> since the mouse interrupt does have a lower priority, it's serviced
> not very often and with huge delays.
> 
> In such a case the network driver should either use interrupt mitigation
> if the cards supports it (reading many packets per one interrupt) or
> switch to a polled mode.

Has this problem been observed in 2.4 kernels?


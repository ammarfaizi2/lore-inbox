Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbUB0Slo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbUB0SlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:41:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:22658 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262952AbUB0Sjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:39:44 -0500
Date: Fri, 27 Feb 2004 13:42:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
In-Reply-To: <403F894C.1050808@nortelnetworks.com>
Message-ID: <Pine.LNX.4.53.0402271336010.8356@chaos>
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com>
 <403F894C.1050808@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Chris Friesen wrote:

> Grover, Andrew wrote:
>
> > If a device later in the handler chain is also interrupting, then the
> > interrupt will immediately trigger again. The irq line will remain
> > asserted until nobody is asserting it.
>
> I thought I saw examples of edge-triggered shared interrupts earlier in
> the thread.  Doesn't that give the reason for this behaviour?
>
> Chris
>
> --
> Chris Friesen                    | MailStop: 043/33/F10
> Nortel Networks                  | work: (613) 765-0557
> 3500 Carling Avenue              | fax:  (613) 765-2986
> Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

In the early IBM/AT, there was a port to which a user of
a shared "edge" interrupt could write. If the interrupt
line was still asserted, this would generate another edge.

This meant that any ISR needed to know about other users
of the same interrupt. This is probably why it didn't
catch on.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



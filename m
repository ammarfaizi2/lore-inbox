Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbUKVPPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbUKVPPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUKVPPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 10:15:17 -0500
Received: from siaag1af.compuserve.com ([149.174.40.8]:61337 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S262161AbUKVPM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:12:57 -0500
Date: Mon, 22 Nov 2004 10:11:01 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: X86_64: Many Lost ticks
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "kernel-stuff@comcast.net" <kernel-stuff@comcast.net>,
       Andi Kleen <ak@suse.de>
Message-ID: <200411221012_MC3-1-8F2C-FF45@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> The thing is, without the IOAPIC enable it's essentially a no operation 
> since i8259 mode wouldn't use the pin information.

  ...until the user force-enables the IOAPIC.  Then the timer pin
overrides will be ignored as they should be.

  My goal was to fix bugs without altering default behavior, so anyone with
broken IOAPIC mode would not suddenly see problems unless they changed a
startup parameter.


--Chuck Ebbert  20-Nov-04  23:58:19

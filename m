Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTD3CWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 22:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTD3CWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 22:22:32 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:64705 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261702AbTD3CWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 22:22:31 -0400
Date: Tue, 29 Apr 2003 22:33:09 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: desc v0.61 found a 2.5 kernel bug
To: Gabriel Paubert <paubert@iram.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304292234_MC3-1-369F-3000@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:

>>  And shouldn't CR3 be intitialized in case anyone actually wants to
>> switch back to the kernel TSS?
>
> For now no, since the only task gate ever taken (double fault), never
> returns (you don't want to update the TSS's CR3 field on every 
> switch_to() so you would have to do it in the task gate return 
> path, as well as having a correct LDT field).

  I want to write a TSS-based debug exception handler that just does
an iret when it gets invoked.  For now it looks easier to just keep
CR3 up-to-date on every switch.

> However, returning from a task gate is so much fraught with races wrt 
> segment registers that the best thing to do is to avoid it.

 Even with interrupts off?


------
 Chuck

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbTDEKOJ (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 05:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTDEKOJ (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 05:14:09 -0500
Received: from siaag2af.compuserve.com ([149.174.40.136]:4588 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S261999AbTDEKOI (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 05:14:08 -0500
Date: Sat, 5 Apr 2003 05:24:39 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] New cpu macro and i386 cleanup
To: Robert Love <rml@tech9.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304050525_MC3-1-331B-F7E3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> I like, although I am not hot on the name, but that is just taste.


I found myself wishing for C++ just for the function overloading so
it could be 'is_current(cpu)' or similar.


> One minor nit: it is not preempt-safe.


I was wondering whether the code I converted was running with preempt
disabled or not but didn't check.  (The very thought of preempt on
SMP scares me anyway, so I avoid it.)

smp_processor_id() is not preempt-safe either, since the id could
change before you even get a chance to use the value.  How many
thousands of lines of code remain that were written assuming things
would not change underneath them in kernel mode?


> Maybe put a comment above it like:


How about one for the whole kernel?

        /**********
         * WARNING: Use preempt at your own risk.
         **********/  

--
 Chuck
 I am not a number!

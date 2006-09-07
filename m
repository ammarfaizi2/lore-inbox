Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWIGUtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWIGUtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 16:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWIGUtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 16:49:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932070AbWIGUtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 16:49:03 -0400
Date: Thu, 7 Sep 2006 13:48:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: ankita@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fernando@oss.ntt.co.jp, maneesh@in.ibm.com
Subject: Re: [RFC] Linux Kernel Dump Test Module
Message-Id: <20060907134850.c05f3be2.akpm@osdl.org>
In-Reply-To: <20060907135329.GA17937@in.ibm.com>
References: <20060907135329.GA17937@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 19:23:29 +0530
Ankita Garg <ankita@in.ibm.com> wrote:

> Please find below a patch for a simple module to test Linux Kernel Dump 
> mechanism. This module uses jprobes to install/activate pre-defined crash
> points. At different crash points, various types of crashing scenarios 
> are created like a BUG(), panic(), exception, recursive loop and stack 
> overflow. The user can activate a crash point with specific type by
> providing parameters at the time of module insertion. Please see the file
> header for usage information. The module is based on the Linux Kernel
> Dump Test Tool by Fernando <http://lkdtt.sourceforge.net>.
> 
> This module could be merged with mainline. Jprobes is used here so that the 
> context in which crash point is hit, could be maintained. This implements
> all the crash points as done by LKDTT except the one in the middle of 
> tasklet_action(). 

"could be merged with mainline": why "could"?  What would be the
disadvantages of doing this?

I think having test code like this in mainline is a good idea, particularly
for a subsystem like [kj]probes.

It's a bit regrettable that the code "knows" about particular not-exported,
arch-specific core kernel functions, but I guess those don't change very
often, so we won't be forever patching this module.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUGPDbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUGPDbF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 23:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUGPDbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 23:31:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:39871 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266327AbUGPDbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 23:31:03 -0400
Subject: Re: sched domains bringup race?
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40F74599.7000606@yahoo.com.au>
References: <1089944026.32312.47.camel@nighthawk>
	 <40F74599.7000606@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1089948659.6886.2.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Jul 2004 20:30:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-15 at 20:03, Nick Piggin wrote:
> It shouldn't because sched_init sets up dummy domains for
> all runqueues.
> 
> Obviously something is going wrong somewhere though.

Hmmm, but there still might be some concurrency problems, right?  There
isn't any locking while the setup is being done, so are all of the
intermediate initialization states valid?  Or, could one of the CPUs be
catching the init code in the middle of an operation?

-- Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265421AbUEUGhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265421AbUEUGhk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 02:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUEUGhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 02:37:40 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58036 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265421AbUEUGhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 02:37:38 -0400
Date: Thu, 20 May 2004 23:37:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: brettspamacct@fastclick.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Message-ID: <273180000.1085121453@[10.10.2.4]>
In-Reply-To: <40AD52A4.3060607@fastclick.com>
References: <40AD52A4.3060607@fastclick.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Say you have a bunch of single-threaded processes on a NUMA machine. 
> Does the kernel make sure to prefer allocations using a certain CPU's 
> memory, preferring to run a given process on the CPU which contains 
> its memory?  Or should I use the NUMA API(libnuma) to spell this out 
> to the kernel? Does the kernel do the right thing in this case?

The kernel will generally do the right thing (process local alloc) by
default. In 99% of cases, you don't want to muck with it - unless you're
running one single app dominating the whole system, and nothing else is
going on, you probably don't want to specify anything explicitly.

M.


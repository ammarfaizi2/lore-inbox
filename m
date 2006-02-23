Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWBWRcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWBWRcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWBWRcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:32:14 -0500
Received: from fsmlabs.com ([168.103.115.128]:44246 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751765AbWBWRcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:32:13 -0500
X-ASG-Debug-ID: 1140715931-8613-40-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 23 Feb 2006 09:36:43 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Arjan van de Ven <arjan@linux.intel.com>
cc: linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org, akpm@osdl.org,
       mingo@elte.hu
X-ASG-Orig-Subj: Re: Patch to reorder functions in the vmlinux to a defined order
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
In-Reply-To: <1140707358.4672.67.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0602230933080.1579@montezuma.fsmlabs.com>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
 <1140707358.4672.67.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9111
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Arjan van de Ven wrote:

> This patch puts the infrastructure in place to allow for a reordering of
> functions based inside the vmlinux. The general idea is that it is possible
> to put all "common" functions into the first 2Mb of the code, so that they
> are covered by one TLB entry. This as opposed to the current situation where
> a typical vmlinux covers about 3.5Mb (on x86-64) and thus 2 TLB entries.
> (This patch depends on the previous patch to pin head.S as first in the order)

Hello Arjan,
	Assuming that functions defined in an object file are related and 
hence benefit from cache spatial locality, doesn't this affect this 
greatly? It would seem that with regards to the kernel image on x86, (2MB) 
TLB usage isn't as scarce a resource as icache.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1762642AbWLKHwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762642AbWLKHwd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 02:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762643AbWLKHwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 02:52:33 -0500
Received: from mx3.cs.washington.edu ([128.208.3.132]:35899 "EHLO
	mx3.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762642AbWLKHwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 02:52:32 -0500
Date: Sun, 10 Dec 2006 23:52:20 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [Patch](memory hotplug) Fix compile error for i386 with NUMA
 config
In-Reply-To: <20061211115829.AD68.Y-GOTO@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64N.0612102351280.9898@attu4.cs.washington.edu>
References: <20061209183320.0761.Y-GOTO@jp.fujitsu.com>
 <Pine.LNX.4.64N.0612090318510.11325@attu4.cs.washington.edu>
 <20061211115829.AD68.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006, Yasunori Goto wrote:

> No.
> Other arch's arch_add_memory() and remove_memory() have been already
> used for NUMA case too. But i386 didn't do it because just 
> contig_page_data is used. 
> Current NODE_DATA() macro is defined both case appropriately.
> So, this #ifdef is redundant now.
> 

Then I assume the comment directly above this change is also redundant 
since it explicitly states that the following code is for the non-NUMA 
case.

		David

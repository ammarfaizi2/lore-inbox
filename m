Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbUAPUtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265895AbUAPUtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:49:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:51952 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265889AbUAPUtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:49:12 -0500
Message-ID: <40084E33.1070003@mvista.com>
Date: Fri, 16 Jan 2004 12:48:51 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Pavel Machek <pavel@suse.cz>, Matt Mackall <mpm@selenic.com>,
       discuss@x86-64.org
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
References: <200401161759.59098.amitkale@emsyssoft.com>
In-Reply-To: <200401161759.59098.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> Hi,
> 
> KGDB 2.0.3 is available at 
> http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> 
> Ethernet interface still doesn't work. It responds to gdb for a couple of 
> packets and then panics. gdb log for ethernet interface is pasted below.
> 
> It panics and enter kgdb_handle_exception recursively and silently. To see the 
> panic on screen make kgdb_handle_exception return immediately if 
> kgdb_connected is non-zero. 
> 
> Panic trace is pasted below. It panics in skb_release_data. Looks like skb 
> handling will have to changed to be have kgdb specific buffers.

Well, this is one step to independence.  That would imply a small memory 
allocator in kgdb itself.  A good thing IMHO.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWDEEaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWDEEaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 00:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWDEEaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 00:30:10 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:41114 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750877AbWDEEaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 00:30:07 -0400
Date: Wed, 5 Apr 2006 13:31:35 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: nanhai.zou@intel.com, khalid_aziz@hp.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org, linux-ia64@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kexec on ia64
Message-Id: <20060405133135.fda5bd82.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <m1vetoivn6.fsf@ebiederm.dsl.xmission.com>
References: <08B1877B2880CE42811294894F33AD5C053A82@pdsmsx411.ccr.corp.intel.com>
	<20060405101243.e3e4f772.kamezawa.hiroyu@jp.fujitsu.com>
	<m1vetoivn6.fsf@ebiederm.dsl.xmission.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2006 20:49:49 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> 
> > Hi, I have a question about kexec/kdump.
> >
> > How does kdump know memory layout (of old kernel) now ?
> >
> > I'm working for memory hotplug. When memory is hot-added, memory layout changes.
> > But I think there is no code to manage memory layout information of added
> > memory.
> 
> It is passed from one kernel to another, and it is memorized when you load
> the crash dump kernel.  If your memory layout changes you need to reload
> the crash dump kernel from user space with the appropriate hotplug script.  
> 
> Unless this happens often it shouldn't be a problem. 
> 

> And yes this does leave a small race during which kexec on panic won't
> work.

Hmm.. Okay. 
Before reloading kdump kernel, kdump continues to use old information.
(when adding, it's not be big problem.)

Thank you.
- Kame


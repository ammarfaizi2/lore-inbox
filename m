Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWDECvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWDECvE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 22:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWDECvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 22:51:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61587 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751084AbWDECvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 22:51:02 -0400
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: "Zou, Nanhai" <nanhai.zou@intel.com>, khalid_aziz@hp.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       linux-ia64@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kexec on ia64
References: <08B1877B2880CE42811294894F33AD5C053A82@pdsmsx411.ccr.corp.intel.com>
	<20060405101243.e3e4f772.kamezawa.hiroyu@jp.fujitsu.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Apr 2006 20:49:49 -0600
In-Reply-To: <20060405101243.e3e4f772.kamezawa.hiroyu@jp.fujitsu.com> (KAMEZAWA
 Hiroyuki's message of "Wed, 5 Apr 2006 10:12:43 +0900")
Message-ID: <m1vetoivn6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> Hi, I have a question about kexec/kdump.
>
> How does kdump know memory layout (of old kernel) now ?
>
> I'm working for memory hotplug. When memory is hot-added, memory layout changes.
> But I think there is no code to manage memory layout information of added
> memory.

It is passed from one kernel to another, and it is memorized when you load
the crash dump kernel.  If your memory layout changes you need to reload
the crash dump kernel from user space with the appropriate hotplug script.  

Unless this happens often it shouldn't be a problem. 

And yes this does leave a small race during which kexec on panic won't
work.

Eric


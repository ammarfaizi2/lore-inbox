Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWHUVAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWHUVAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHUVAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:00:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46296 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751093AbWHUVAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:00:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com, Magnus Damm <magnus.damm@gmail.com>,
       Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	<200608211624.11005.ak@suse.de> <20060821144657.GE9549@in.ibm.com>
	<200608211704.03061.ak@suse.de>
	<m1fyfpuabb.fsf@ebiederm.dsl.xmission.com>
	<20060821221009.a43cfbf0.ak@suse.de>
Date: Mon, 21 Aug 2006 15:00:06 -0600
In-Reply-To: <20060821221009.a43cfbf0.ak@suse.de> (Andi Kleen's message of
	"Mon, 21 Aug 2006 22:10:09 +0200")
Message-ID: <m17j11u7mx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> I'm not certain I caught everything but as far as I know I did.
>> Part of that was by having the code run at a fixed virtual address so
>> we still live in the last 2GB of the virtual address space.
>
> You changed the -2GB (or rather -40MB unpatched) mapping to not necessarily 
> be linear?

I left it linear but I removed assumptions about which physical address it
goes to.

>  There are a couple of assumptions that it is, including at boot up
> (it doubles as the 1:1 mapping then) and in change_page_attr() and in
> suspend/resume.

Yes.  Those all sound familiar.

I removed the doubling as the 1:1 physical mapping.

Eric

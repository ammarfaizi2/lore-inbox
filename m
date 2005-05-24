Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVEXMaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVEXMaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVEXMaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:30:20 -0400
Received: from colin.muc.de ([193.149.48.1]:43535 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262035AbVEXM2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:28:18 -0400
Date: 24 May 2005 14:28:17 +0200
Date: Tue, 24 May 2005 14:28:17 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, zwane@arm.linux.org.uk, rusty@rustycorp.com.au,
       vatsa@in.ibm.com, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [patch 4/4] CPU Hotplug support for X86_64
Message-ID: <20050524122817.GD86182@muc.de>
References: <20050524081113.409604000@csdlinux-2.jf.intel.com> <20050524081305.149581000@csdlinux-2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524081305.149581000@csdlinux-2.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 01:11:17AM -0700, Ashok Raj wrote:
> This patch tries to eliminate a race condition with IPI broadcast and 
> CPU hotplug. Since when we broadcast we dont have control on what cpus
> see a spurious intr, or possiblity of receiving an intr when the cpu is
> just in process of comming up, we choose to send targetted IPI only to online
> cpus.

I thought you had fixed that already in the other patch 
with the locking of call_lock. Or did I miss something?


I dont like this patch.

-Andi

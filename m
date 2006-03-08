Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWCHHhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWCHHhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbWCHHhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:37:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751120AbWCHHhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:37:00 -0500
Date: Tue, 7 Mar 2006 23:35:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [PATCH][BUG] fix bug in ACPI based CPU hotplug
Message-Id: <20060307233507.6ad0858f.akpm@osdl.org>
In-Reply-To: <440E8723.7030008@soft.fujitsu.com>
References: <440E8723.7030008@soft.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com> wrote:
>
> This patch fixes a serious bug in ACPI based CPU hotplug code. Because
>  of this bug, ACPI based CPU hotplug will always fail if NR_CPUS is
>  equal to or more than 255.

Looks rather similar to
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/broken-out/acpi-signedness-fix-2.patch
;)

I think they're functionally equivalent - the only difference is the ==-1
versus <0 comparisons.


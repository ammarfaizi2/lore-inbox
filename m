Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965556AbWKOHNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965556AbWKOHNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965838AbWKOHNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:13:46 -0500
Received: from hera.kernel.org ([140.211.167.34]:48548 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965556AbWKOHNp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:13:45 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: "J.A. =?iso-8859-1?q?Magall=F3n?=" <jamagallon@ono.com>
Subject: Re: SMP and ACPI
Date: Wed, 15 Nov 2006 02:16:37 -0500
User-Agent: KMail/1.8.2
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
References: <20061114225848.160cc46f@werewolf-wl>
In-Reply-To: <20061114225848.160cc46f@werewolf-wl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611150216.37471.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 16:58, J.A. Magallón wrote:

>...  is it still needed to select ACPI manually to
> get SMP working, or does SMP select the minimal part of ACPI that is needed ?

if speaking of recent 2.6...

CONFIG_SMP and CONFIG_ACPI are independent.

So if you select CONFIG_SMP and don't select CONFIG_ACPI,
then your PC will need to support MPS if Linux is going to bring up the processors...

There no longer exists a build-time concept of "minimal part of ACPI that is needed" --
you either include CONFIG_ACPI or you exclude it.  However, at boot-time, "acpi=ht"
is still present -- primarily for some old systems with HT  that didn't run ACPI well.
No idea if this this is still needed in practice but occasionally acpi=ht comes in handy
to debug table related issues.

-Len

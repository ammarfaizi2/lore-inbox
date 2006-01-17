Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWAQOEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWAQOEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWAQOEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:04:04 -0500
Received: from ns2.suse.de ([195.135.220.15]:7897 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932496AbWAQOEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:04:01 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH/RFC] Unify mapping from PXM to node id.
Date: Tue, 17 Jan 2006 15:05:32 +0100
User-Agent: KMail/1.8
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>, "Brown, Len" <len.brown@intel.com>
References: <20060117205442.5B9A.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20060117205442.5B9A.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171505.32933.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 13:36, Yasunori Goto wrote:
> Hello.
>
> This patch is to unify mapping from pxm to node id as a common code.
> In current code, i386, x86-64, and ia64 have its mapping by each own code.
> But PXM is defined by ACPI and node id is used generically. So,
> I think there is no reason to define it on each arch's code.
> This mapping should be written at drivers/acpi/numa.c.
>

> Please comment.

The array is unnecessary big - PXMs are only 8bit so it could be u8.

Looks ok to me on x86-64 in principle, except that the __devinits should
be probably __cpuinits. I haven't tested/compiled it though

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751981AbWCFRpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbWCFRpG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbWCFRpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:45:05 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:7809 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1751960AbWCFRpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:45:02 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: edac slab corruption.
Date: Mon, 6 Mar 2006 09:44:53 -0800
User-Agent: KMail/1.5.3
Cc: norsk5@xmission.com, dthompson@linuxnetworx.com
References: <20060305074355.GA3151@redhat.com>
In-Reply-To: <20060305074355.GA3151@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603060944.53601.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 March 2006 23:43, Dave Jones wrote:
> rmmod e752x_edac edac_mc
> Wait a few seconds...
>
> EDAC MC0: Removed device 0 for "e752x_edac" E7525: PCI 0000:00:00.0
> Slab corruption: start=ffff81003fc5a000, len=4096
>
> Call Trace: <ffffffff8017bcab>{check_poison_obj+121}
>        <ffffffff802028a8>{kobject_uevent+676}
> <ffffffff8017be34>{cache_alloc_debugcheck_after+48}
> <ffffffff802028a8>{kobject_uevent+676}
> <ffffffff8017dd52>{__kmalloc_track_caller+301}
> <ffffffff802db731>{__alloc_skb+97} <ffffffff80202701>{kobject_uevent+253}
> <ffffffff802028a8>{kobject_uevent+676}
> <ffffffff80201fd6>{kobject_unregister+14}
> <ffffffff8026f273>{bus_remove_driver+126}
> <ffffffff8027004a>{driver_unregister+9}
> <ffffffff8020f4a8>{pci_unregister_driver+16}
> <ffffffff8014ec37>{sys_delete_module+551}
> <ffffffff8010dbdc>{syscall_trace_enter+156}
> <ffffffff8010a91c>{tracesys+209} 0f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 6a 6b 6b 6b
>
> 		Dave

Which version of the EDAC code was this observed with?

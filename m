Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUEFPIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUEFPIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUEFPIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:08:45 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:13003 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262438AbUEFPIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:08:42 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Sourav Sen" <souravs@india.hp.com>
Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
Date: Thu, 6 May 2004 09:08:38 -0600
User-Agent: KMail/1.6.2
Cc: "'Matt Domsch'" <Matt_Domsch@dell.com>, <matthew.e.tolentino@intel.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <tony.luck@intel.com>
References: <004801c4336c$daae5840$39624c0f@india.hp.com>
In-Reply-To: <004801c4336c$daae5840$39624c0f@india.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405060908.39311.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 May 2004 7:20 am, Sourav Sen wrote:
> + 1) Why does userspace / humans need to know this?  For 
> + debugging firmware?
> 	
> 	Maybe. But the point I had in mind is, say for example
> memory diagnostics applications/exercisers which reads (Blind
> reads, without caring about contents) memory
> to uncover errors (single bit errors)  can use
> this to know the usable ranges and map them thru /dev/mem and
> read those ranges.

For this application, the EFI memory map isn't what you want.
It's a pretty good approximation today, but the day when we'll
be able to hot-add memory is fast approaching, and the EFI map
won't mention anything added after boot.  We'll discover all
that via ACPI (on ia64).

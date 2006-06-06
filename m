Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWFFXoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWFFXoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWFFXoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:44:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:23255 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751365AbWFFXoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:44:19 -0400
Message-ID: <44861348.5030200@zytor.com>
Date: Tue, 06 Jun 2006 16:44:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: linux-kernel@vger.kernel.org, iss_storagedev@hp.com,
       Mike Miller <mike.miller@hp.com>
Subject: Re: kinit problem with cciss root device
References: <200606061640.48644.bjorn.helgaas@hp.com>
In-Reply-To: <200606061640.48644.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> kinit converts "root=/dev/cciss/c0d0p1" to "cciss.c0d0", which
> doesn't exist under /sys/block because register_disk() converts
> "cciss/c0d0" to "cciss!c0d0" (note "!", not ".").
> 
> I don't know whether it's the *right* fix, but the patch below
> makes things work.  It still doesn't make kinit exactly match
> the register_disk() behavior because register_disk() only changes
> the first "/" in the string.
> 

That's still the right thing; obviously register_disk() will need to change if we ever 
have deeper trees.

Could you re-send that hunk as a proper patch with Signed-off-by: et al?

Thanks,

	-hpa

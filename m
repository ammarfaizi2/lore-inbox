Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbULHPoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbULHPoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 10:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbULHPoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 10:44:10 -0500
Received: from main.gmane.org ([80.91.229.2]:34002 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261235AbULHPoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 10:44:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Date: Wed, 08 Dec 2004 10:44:07 -0500
Message-ID: <87oeh4bxrs.fsf@coraid.com>
References: <87acsrqval.fsf@coraid.com> <20041206162153.GH16958@lug-owl.de>
	<20041207130015.GA983@openzaurus.ucw.cz> <41B6D11D.9040107@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:xge+cCSLBObJL644LEgmOR/mUi8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@hist.no> writes:

> Pavel Machek wrote:
>
>>
>>Well, at least it has a chance to correctly work in low-memory conditions,
>>and it might be possible to swap over AoE.
>>ARPs are real problem there.

...
> Well, how about caching the hw address of the AoE device
> somewhere in the data structure describing the block device?
> Then you won't need to ARP for it, and I guess that address isn't
> likely to change while the device is in use?

The ATA over Ethernet protocol doesn't use IP addresses, so there's no
need to use ARP.  Pavel Machek appears to be noting that because ARP
is not needed, AoE may be easier to do in situations where memory is
scarce.

-- 
  Ed L Cashin <ecashin@coraid.com>


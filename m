Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWG2Qbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWG2Qbx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 12:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWG2Qbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 12:31:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:12747 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932163AbWG2Qbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 12:31:51 -0400
From: Andi Kleen <ak@suse.de>
To: kmannth@us.ibm.com
Subject: Re: [Patch] 1/5 in support of hot-add memory x86_64 nodes_add cleanup
Date: Sat, 29 Jul 2006 18:24:25 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       discuss <discuss@x86-64.org>, andrew <akpm@osdl.org>,
       dave hansen <haveblue@us.ibm.com>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>, konrad <darnok@us.ibm.com>
References: <1154141535.5874.145.camel@keithlap>
In-Reply-To: <1154141535.5874.145.camel@keithlap>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607291824.25584.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you add attachments (which are harder to review because they cannot be 
quoted) put at least a copy of the description into the attachment and make
them inline.

One thing that's unclear to me is why you make the reserve hotadd Kconfig
user visible (and why put it into Kconfig at all). I don't think it should be 
user visible.

Also most of the patch seems to be renaming a variable which seems somewhat
pointless?

-Andi


On Saturday 29 July 2006 04:52, keith mannthey wrote:
>   This patch cleans up the srat.c file with respects to the 2 hot-add
> paths available.  It creates Kconfig options to represent the desired
> functionality and implements their usage.
>
>   The current code already saves the information need (NUMA locality of
> hot-add memory ranges) for MEMORY_HOTPLUG in the RESERVE_MEMORY path.  I
> amend the memory parsing code to support the needs of both and save the
> nodes_add data for use at runtime.
>
> Built against 2.6.18-rc2
>
> Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>

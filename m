Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267901AbUHUVmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267901AbUHUVmm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267909AbUHUVmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:42:42 -0400
Received: from mail2.ewetel.de ([212.6.122.16]:12974 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S267901AbUHUVml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:42:41 -0400
Date: Sat, 21 Aug 2004 23:42:30 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <412770EA.nail9DO11D18Y@burner>
Message-ID: <Pine.LNX.4.58.0408212336040.20146@neptune.local>
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
 <2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
 <2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
 <2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
 <2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
 <E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004, Joerg Schilling wrote:

> So changing the kernel to require write permissions would be a simple
> fix that would help without breaking cdrtools as libscg of course opens
> the devices with O_RDWR.

I agree, but Linus obviously thought otherwise. Reverting that and
doing the above fix instead would create three different behaviours
for different 2.6.x kernel versions, which is also undesirable.

> I am not against a long term change that would require euid root too,
> but this should be announced early enough to allow prominent users of
> the interface to keep track of the interface changes.

Too late for that now, no matter whether we like it or not... however,
at least the discussion now has shown that changes to this interface
need to be considered carefully, so maybe the future will be
bright. ;)

-- 
Ciao,
Pascal

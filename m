Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWBGMGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWBGMGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWBGMGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:06:24 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53447 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965044AbWBGMGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:06:23 -0500
Subject: Re: non-fakeraid controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: alex-lists-linux-kernel@yuriev.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060207015126.GA12236@s2.yuriev.com>
References: <20060207015126.GA12236@s2.yuriev.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Feb 2006 12:08:25 +0000
Message-Id: <1139314105.18391.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-06 at 20:51 -0500, alex-lists-linux-kernel@yuriev.com
wrote:
> 	Does anyone has a list/refence/etc on reasonably modern SCSI
> controllers (at least u160) in a non-fakeraid way i.e. the way that would
> allow linux to boot from a RAID protected disk array when one of the drives
> in the array failed even if the root filesystem is located on the same
> array?

Most raid (soft or otherwise) will usually do it. I don't know any SCSI
hardware which will do it reliably unless you go fibrechannel or SATA
simply because a dead scsi drive can and sometimes does hang the entire
shared bus.

The majority of the time the aacraid based cards will do what you need
(most of the time anyway) and can also do a lot of on the fly recovery
and management. The fusions can do some raid stuff of this nature. Most
of the newer hardware is going SATA however.

Alan


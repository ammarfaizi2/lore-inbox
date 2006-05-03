Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWECWWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWECWWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 18:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWECWWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 18:22:42 -0400
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:55703 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1751383AbWECWWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 18:22:41 -0400
Message-Id: <4458D8C60200003600006167@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 03 May 2006 16:22:30 -0600
From: "Doug Thompson" <dthompson@lnxi.com>
To: <tim@buttersideup.com>, <alan@lxorguk.ukuu.org.uk>
Cc: <mark.gross@intel.com>, <soo.keong.ong@intel.com>,
       <steven.carbonari@intel.com>, <zhenyu.z.wang@intel.com>,
       <bluesmoke-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Problems with EDAC coexisting with BIOS
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Alan Cox <alan@lxorguk.ukuu.org.uk> 05/03/06 3:44 PM >>>
On Mer, 2006-05-03 at 21:25 +0100, Tim Small wrote:
>> something with NMI-signalled errors, I was wondering what the
problems 
>> with using NMI-signalled ECC errors were?

>The big problem with NMI is that it can occur *during* a PCI
>configuration sequence (ie during pci_config_* functions). That means
we
>can't safely do some I/O, especially configuration space I/O in an NMI
>handler. At best we could set a flag and catch it afterwards.


Dave Peterson did submit a set of patches to provide a deferred calling
mechanism triggered by the NMI handler. I am in the process of reading
up on that patch. It currently is in the bluesmoke project.

doug t



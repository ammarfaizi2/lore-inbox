Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264959AbUGGRAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbUGGRAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUGGRAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:00:55 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:46926 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264959AbUGGRAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:00:54 -0400
To: Helge Hafting <helge.hafting@hist.no>
Cc: Davide Rossetti <davide.rossetti@roma1.infn.it>,
       linux-kernel@vger.kernel.org
Subject: Re: MSI to memory?
X-Message-Flag: Warning: May contain useful information
References: <200407011215.59723.bjorn.helgaas@hp.com>
	<20040701115339.A4265@unix-os.sc.intel.com>
	<40EBED33.3050707@roma1.infn.it> <40EBF07B.8040003@hist.no>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 07 Jul 2004 09:59:14 -0700
In-Reply-To: <40EBF07B.8040003@hist.no> (Helge Hafting's message of "Wed, 07
 Jul 2004 14:45:47 +0200")
Message-ID: <52vfgzoisd.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Jul 2004 16:59:14.0431 (UTC) FILETIME=[BB7CA0F0:01C46443]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Helge> Won't that put a bad load on the bus?  Someone else might
    Helge> need it: * Another cpu in a smp system * Any device doing
    Helge> bus-master transfers, even in a UP system

Actually with MSI, the PCI device writes directly to a host address.
In the proposed usage in this mail thread, the address is in host
memory, so there's no bus load to poll the memory.  Presumably the
memory will be pulled into cache for the duration of the poll loop, so
there's not even any memory bandwidth consumed.  (Of course this only
works on an architecture where PCI DMA is cache coherent)

 - Roland

Date: Wed, 07 Jul 2004 09:59:04 -0700
In-Reply-To: <40EBF07B.8040003@hist.no> (Helge Hafting's message of "Wed, 07 Jul 2004 14:45:47 +0200")
Message-ID: <52wu1foisn.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through Obscurity, linux)

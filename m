Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUEWBPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUEWBPy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 21:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUEWBPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 21:15:54 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:15047 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262065AbUEWBPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 21:15:53 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com (Eric W. Biederman), linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
References: <20040522013636.61efef73.akpm@osdl.org>
	<m165aorm70.fsf@ebiederm.dsl.xmission.com>
	<20040522180837.3d3cc8a9.akpm@osdl.org>
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: 22 May 2004 18:15:51 -0700
In-Reply-To: <20040522180837.3d3cc8a9.akpm@osdl.org>
Message-ID: <527jv4ymd4.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 May 2004 01:15:51.0670 (UTC) FILETIME=[7D05F960:01C44063]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> I don't think we can expect all architectures to be able
    Andrew> to implement atomic 64-bit IO's, can we?

    Andrew> ergo, drivers which want to use readq and writeq should
    Andrew> provide the appropriate locking.

Perhaps we should have ARCH_HAS_ATOMIC_WRITEQ or something so that
drivers don't add the overhead of locking on architectures where it's
not necessary?

(I happen to be working on a driver that needs atomic 64-bit writes,
and where those writes happen to be in the fast path)

Thanks,
  Roland

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWBTPDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWBTPDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWBTPDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:03:32 -0500
Received: from ozlabs.org ([203.10.76.45]:65506 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030272AbWBTPDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:03:32 -0500
Date: Tue, 21 Feb 2006 01:59:05 +1100
From: Anton Blanchard <anton@samba.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 01/22] Add powerpc-specific clear_cacheline(), which just compiles to "dcbz".
Message-ID: <20060220145904.GA19895@krispykreme>
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005704.13620.88286.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005704.13620.88286.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> This is horribly non-portable.  How much of a performance difference
> does it make?  How does it do on ppc64 systems where the cacheline
> size is not 32?

Yes, if anything we should catch cacheline aligned, multiple cacheline
sized zeroing in memset. 

Anton

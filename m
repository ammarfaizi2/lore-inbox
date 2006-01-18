Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWARXIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWARXIF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWARXIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:08:05 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40615 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030473AbWARXIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:08:02 -0500
Subject: Re: [PATCH 1/8] Notifier chain update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060118214204.GG16285@kvack.org>
References: <20060118181955.GF16285@kvack.org>
	 <Pine.LNX.4.44L0.0601181517060.4974-100000@iolanthe.rowland.org>
	 <20060118214204.GG16285@kvack.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 23:07:33 +0000
Message-Id: <1137625653.1760.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-18 at 16:42 -0500, Benjamin LaHaise wrote:
> A notifier callee should not be sleeping, if anything it should be putting 
> its work onto a workqueue and completing it when it gets scheduled if it 
> has to do something that blocks.

Notifiers impose sequential ordering and the ability to abort or
complete a sequence early. Workqueues do something different.


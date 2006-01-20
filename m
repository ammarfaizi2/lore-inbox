Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422698AbWATEru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422698AbWATEru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWATEru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:47:50 -0500
Received: from ozlabs.org ([203.10.76.45]:42399 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422698AbWATEru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:47:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17360.27469.840898.303811@cargo.ozlabs.ibm.com>
Date: Fri, 20 Jan 2006 15:47:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, tony.luck@intel.com
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
In-Reply-To: <20060118151816.GA82365@muc.de>
References: <4370AF4A.76F0.0078.0@novell.com>
	<20060114045635.1462fb9e.akpm@osdl.org>
	<17358.11049.367188.552649@cargo.ozlabs.ibm.com>
	<20060118151816.GA82365@muc.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:

> The module loader should be discarding these sections on most architectures
> because there is nothing that needs them and it's just a waste of memory
> to store them.

Apparently the module loader loads all sections marked SHF_ALLOC,
reasonably enough.

Why would we want the unwind tables in the .ko but not in kernel
memory?  Isn't the point of this so that we can add an in-kernel
unwinder?

Paul.

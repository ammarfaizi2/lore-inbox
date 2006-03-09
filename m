Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWCIB0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWCIB0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 20:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWCIB0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 20:26:14 -0500
Received: from mx.pathscale.com ([64.160.42.68]:9357 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750756AbWCIB0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 20:26:13 -0500
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store
	buffers
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, akpm@osdl.org,
       paulus@samba.org, bcrl@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <200603081538.32234.ak@suse.de>
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
	 <200603081521.19693.ak@suse.de>
	 <1141855075.27555.14.camel@localhost.localdomain>
	 <200603081538.32234.ak@suse.de>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 17:26:30 -0800
Message-Id: <1141867590.6721.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 15:38 +0100, Andi Kleen wrote:

> Hmm, I reread the thread and with the "i don't need a flush, just ordering" 
> part of your description it makes sense.

Actually, the sfence architecturally guarantees a WC store buffer flush
on x86_64 too, which I need.  Obviously, on CPUs that don't have WC
on-chip, this is not an issue.

> My second objection still stands though. Maybe we should add this as
> part of a generic portable PAT/WC infrastructure. But isolated
> it doesn't make sense.

Fine.  I'll put it in the driver for now, and work on the generic WC
infrastructure in parallel.

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWB1To6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWB1To6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWB1To5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:44:57 -0500
Received: from mx.pathscale.com ([64.160.42.68]:18143 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932529AbWB1To5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:44:57 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602282033.48570.ak@suse.de>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <20060228190354.GE24306@kvack.org>
	 <1141154424.20227.11.camel@serpentine.pathscale.com>
	 <200602282033.48570.ak@suse.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 28 Feb 2006 11:44:51 -0800
Message-Id: <1141155892.20227.26.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 20:33 +0100, Andi Kleen wrote:

> Are you sure you used the right instruction? Normally CLFLUSH is used
> for such things, not a write barrier which really only changes ordering.

Hmm.  It's possible we're just getting lucky because another write
happens somewhere else soon after the last write we perform as part of a
packet send.  Perhaps, for complete correctness, we should be using
CLFLUSH instead of the last barrier.  I'll have to look into this.

Thanks,

	<b


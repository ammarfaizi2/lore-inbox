Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWCHWF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWCHWF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWCHWFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:05:25 -0500
Received: from mx.pathscale.com ([64.160.42.68]:47083 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030220AbWCHWFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:05:24 -0500
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store
	buffers
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, paulus@samba.org,
       benh@kernel.crashing.org, bcrl@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <200603081535.25515.ak@suse.de>
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
	 <1141855591.10606.12.camel@localhost.localdomain>
	 <200603081535.25515.ak@suse.de>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 14:05:47 -0800
Message-Id: <1141855547.27555.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 15:35 +0100, Andi Kleen wrote:

> > How is this different to mmiowb() ?
> 
> I think he intends it to be a flush instead of an ordering.
> (something like CLFLUSH for WC areas)

Exactly.  mmiowb guarantees ordering, but says nothing about timing.
This would guarantee ordering, affect WC store buffers if present, and
try to work in a timely manner.

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>


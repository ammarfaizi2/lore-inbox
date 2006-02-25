Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWBYRLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWBYRLt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 12:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWBYRLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 12:11:49 -0500
Received: from mx.pathscale.com ([64.160.42.68]:46309 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932489AbWBYRLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 12:11:48 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060225142814.GB17844@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <20060225142814.GB17844@kvack.org>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 09:11:57 -0800
Message-Id: <1140887517.9852.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 09:28 -0500, Benjamin LaHaise wrote:

> sfence has no impact 
> on the flushing of the write combining buffers

The sfence instruction guarantees that every store that precedes it in
program order is globally visible, including over the likes of the PCI
bus, before any store instruction that follows the fence.

	<b


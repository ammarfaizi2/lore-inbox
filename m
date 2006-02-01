Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422905AbWBATuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422905AbWBATuC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422904AbWBATuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:50:01 -0500
Received: from mail.enyo.de ([212.9.189.167]:14500 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1422905AbWBATuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:50:01 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AMD64: fix mce_cpu_quirks typos
References: <87fyn2yjpr.fsf@mid.deneb.enyo.de>
	<20060201194400.GB21132@redhat.com>
Date: Wed, 01 Feb 2006 20:49:58 +0100
In-Reply-To: <20060201194400.GB21132@redhat.com> (Dave Jones's message of
	"Wed, 1 Feb 2006 14:44:00 -0500")
Message-ID: <87psm6x3ix.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones:

> On Wed, Feb 01, 2006 at 08:14:56PM +0100, Florian Weimer wrote:
>  > The spurious MCE is TLB-related.  I *think* the bit for the correct
>  > status code is stored at position 10 HEX, not 10 DEC
>
> not true.   According to the BIOS writer guide, it's bit 10.
> The register only defines bits up to bit 12

Okay, so why I'm still getting these MCEs?

MCE 0
CPU 0 4 northbridge TSC 91ec03f09330
ADDR 104500000
  Northbridge GART error
       bit61 = error uncorrected
  TLB error 'generic transaction, level generic'
STATUS a40000000005001b MCGSTATUS 0

They are supposed to be disabled by the quirks routine, aren't they?

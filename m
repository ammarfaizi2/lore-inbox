Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVAEQ2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVAEQ2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVAEQ0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:26:24 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:7571 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261207AbVAEQY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 11:24:56 -0500
Date: Wed, 5 Jan 2005 08:24:41 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V3 [4/4]: Driver for hardware zeroing on Altix
In-Reply-To: <m1sm5gd3i0.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0501050822520.7586@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
 <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041515230.1536@schroedinger.engr.sgi.com> <m1sm5gd3i0.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Andi Kleen wrote:

> Christoph Lameter <clameter@sgi.com> writes:
>
> > +	/* Check limitations.
> > +		1. System must be running (weird things happen during bootup)
> > +		2. Size >64KB. Smaller requests cause too much bte traffic
> > +	 */
> > +	if (len >= BTE_MAX_XFER || len < 60000 || system_state != SYSTEM_RUNNING)
> > +		return EINVAL;
>
> surely return -EINVAL;

Anything will do as long as its != 0. But yeah that would more closely
follow convention.

> Also have you thought about doing a similar driver for x86/x86-64 using
> cache bypassing stores?

As you know we do ia64 and I am no expert on x86_64. But the interface for
hardware zeroing is designed for purposes like that.

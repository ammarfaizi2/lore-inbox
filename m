Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVAECQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVAECQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVAECQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:16:52 -0500
Received: from one.firstfloor.org ([213.235.205.2]:7097 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262198AbVAECQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:16:43 -0500
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V3 [4/4]: Driver for hardware zeroing on Altix
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	<41C20E3E.3070209@yahoo.com.au>
	<Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
	<Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
	<Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501041515230.1536@schroedinger.engr.sgi.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 05 Jan 2005 03:16:39 +0100
In-Reply-To: <Pine.LNX.4.58.0501041515230.1536@schroedinger.engr.sgi.com> (Christoph
 Lameter's message of "Tue, 4 Jan 2005 15:16:04 -0800 (PST)")
Message-ID: <m1sm5gd3i0.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:

> +	/* Check limitations.
> +		1. System must be running (weird things happen during bootup)
> +		2. Size >64KB. Smaller requests cause too much bte traffic
> +	 */
> +	if (len >= BTE_MAX_XFER || len < 60000 || system_state != SYSTEM_RUNNING)
> +		return EINVAL;

surely return -EINVAL; 

Also have you thought about doing a similar driver for x86/x86-64 using
cache bypassing stores? 

-Andi

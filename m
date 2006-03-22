Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWCVATR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWCVATR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWCVATQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:19:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30413 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751858AbWCVATP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:19:15 -0500
Date: Tue, 21 Mar 2006 16:21:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, kiran@scalex86.org, alokk@calsoftinc.com,
       penberg@cs.helsinki.fi
Subject: Re: slab: Add transfer_objects() function
Message-Id: <20060321162124.07361de2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603211509180.14245@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603211509180.14245@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> +static int transfer_objects(struct array_cache *to,
> +		struct array_cache *from, int max)

Does this ever get called if !CONFIG_NUMA?

If not, can we provide a non-numa version which just goes BUG and saves
some text?

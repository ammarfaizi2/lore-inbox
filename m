Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbTI3Njy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbTI3Njy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:39:54 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:64389 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261468AbTI3Njx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:39:53 -0400
Date: Tue, 30 Sep 2003 14:39:36 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@redhat.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20030930133936.GA28876@mail.shareable.org>
References: <20030930073814.GA26649@mail.jlokier.co.uk> <20030930132211.GA23333@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930132211.GA23333@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> This looks to be completely gratuitous. Why disable it when we have the
> ability to work around it ?

Because some people expressed a wish to have kernels that don't
contain the workaround code, be they P4-optimised or 486-optimised
kernels.  After all we have kernels that don't contain the F00F
workaround too.  I'm not pushing this patch as is, it's for
considering the pros and cons.

CONFIG_X86_PREFETCH_WORKAROUND makes more makes more sense with the
recently available "split every x86 CPU into individually selectable
options" patch, and, on reflection, that's probably where it belongs.

-- Jamie

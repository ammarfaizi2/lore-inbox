Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbUKVQaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbUKVQaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUKVQ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:27:59 -0500
Received: from holomorphy.com ([207.189.100.168]:2970 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262112AbUKVPjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:39:53 -0500
Date: Mon, 22 Nov 2004 07:39:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brice.Goglin@ens-lyon.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmap_atomic
Message-ID: <20041122153948.GF2714@holomorphy.com>
References: <41A1FDA0.1070204@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A1FDA0.1070204@ens-lyon.fr>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 03:54:24PM +0100, Brice Goglin wrote:
> I would like to know if I can use kmap_atomic with KM_USER[01] type
> within a non-interrupt context. Looking at comments near kmap_atomic
> declarations on sparc or ppc, it seems that this is discouraged.
> But lots of code (like filesystem stuff) are currently using it
> outside of interrupt context.
> Are there special requirements about KM_USER[01] usage in interrupt
> or non-interrupt contexts ?
> Is it documented somewhere how we can use it ?
> What I want to do is just kmap_atomic, copy and kunmap_atomic.

Those comments are stale. This varies by km_type. A given km_type may
only be used in one context. KM_USER0/KM_USER1 are specifically
dedicated to process context copying. KM_IRQ0/KM_IRQ1 are specifically
devoted to interrupt-context copying.


-- wli

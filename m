Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVLFPfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVLFPfu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVLFPfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:35:50 -0500
Received: from [81.2.110.250] ([81.2.110.250]:24523 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964985AbVLFPfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:35:50 -0500
Subject: Re: IDE + CPU Scaling problem on Via EPIA systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: gboyce <gboyce@badbelly.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051128063212.GA18775@redhat.com>
References: <Pine.LNX.4.64.0511272350380.17020@localhost.localdomain>
	 <20051128063212.GA18775@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Dec 2005 16:22:03 +0000
Message-Id: <1133713324.3168.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-28 at 01:32 -0500, Dave Jones wrote:
> On some variants of the VIA C3, we need to quiesce all DMA operations
> before we do a speed transition. We currently don't do that.
> I do have a patch from someone which adds support in the longhaul
> driver to wait for IDE transactions to stop, but to do it cleanly,
> we really need some callbacks into the IDE layer.

I was under the impression you could turn the IO/MEM enable on the root
bridge off momentarily to get the needed DMA pause safely ? Or does it
abort rather than retry at that point ?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWCFTjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWCFTjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWCFTjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:39:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41117 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751173AbWCFTjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:39:13 -0500
Subject: Re: VIA C3 (Ezra C5C) Crashes with longhaul Freq scaling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Shinichi Kudo <randomshinichi4869@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060305043800.GA2253@redhat.com>
References: <8be2e100603040646k7f40e8eai391eb914040cb8f8@mail.gmail.com>
	 <20060305043800.GA2253@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Mar 2006 19:44:10 +0000
Message-Id: <1141674250.26548.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-03-04 at 23:38 -0500, Dave Jones wrote:
> There's an ugly patch below that was submitted, which fixes it for
> some people, but as it's a) ide specific, and b) completely the
> wrong place to do this and c) racy,  I never merged it to mainline.

If I understand the documentation correctly you simply need to disable
the master bit on the root bridge during the transition and the PCI
transactions will be stalled, providing you don't take too long about
it.



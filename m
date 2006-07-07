Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWGGNYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWGGNYi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWGGNYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:24:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751214AbWGGNYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:24:36 -0400
Date: Fri, 7 Jul 2006 15:26:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Michael Kerrisk <michael.kerrisk@gmx.net>, mtk-manpages@gmx.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: splice/tee bugs?
Message-ID: <20060707132651.GZ4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net> <20060707120333.GR4188@suse.de> <20060707122850.GU4188@suse.de> <20060707123110.64140@gmx.net> <20060707124105.GW4188@suse.de> <20060707131247.GX4188@suse.de> <20060707131403.GY4188@suse.de> <1152278514.3111.77.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152278514.3111.77.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07 2006, Arjan van de Ven wrote:
> 
> > I cannot see where this could be happening, Ingo is this valid?
> 
> maybe the test found a way to exit the kernel previously while holding
> the lock ?

I don't see how that could happen. The function in question is
fs/splice.c:link_pipe(). There are no returns in that function, it
always just breaks out and unlocks the two mutexes again.

-- 
Jens Axboe


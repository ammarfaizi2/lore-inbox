Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbUKEMXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbUKEMXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbUKEMXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:23:25 -0500
Received: from cantor.suse.de ([195.135.220.2]:63174 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262663AbUKEMXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:23:08 -0500
Date: Fri, 5 Nov 2004 13:23:06 +0100
From: Andi Kleen <ak@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105122306.GB1287@wotan.suse.de>
References: <20041105001328.3ba97e08.akpm@osdl.org.suse.lists.linux.kernel> <418B5C70.7090206@kolivas.org.suse.lists.linux.kernel> <p73sm7o7br3.fsf@verdi.suse.de> <418B6F18.9090404@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418B6F18.9090404@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 11:16:24PM +1100, Con Kolivas wrote:
> Andi Kleen wrote:
> >Con Kolivas <kernel@kolivas.org> writes:
> >
> >
> >>It's life Jim but not as we know it...
> >>
> >>
> >>This happened during modprobe of alsa modules. Keyboard still alive,
> >>everything else dead; not even sysrq would do anything, netconsole had
> >>no output, luckily this made it to syslog:
> >
> >
> >I just tested modprobing of alsa (snd_intel8x0) and it works for me.
> >Also vmalloc must work at least to some point.
> >
> >Can you confirm it's really caused by 4level by reverting all the 
> >4level-* patches from broken out? 
> 
> I dont recall blaming 4level. When I get a chance I'll try.

I can reproduce it now using a forced big vmalloc. It's probably
4level. Debugging...

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUACTTM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUACTTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:19:12 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:37138 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264095AbUACTTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:19:07 -0500
Date: Sat, 3 Jan 2004 20:19:01 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040103191901.GC3728@alpha.home.local>
References: <1073075108.9851.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073075108.9851.16.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Sat, Jan 03, 2004 at 07:52:36PM +0100, Soeren Sonnenburg wrote:
 
> So it is like 30 times slower on 2.6. when running for the first time...
> this also happens if I do e.g. find ./ and watch the output pass by... 
> 
> This is without preemption on powerpc...
> 
> Anyone else with that problem - ideas of the cause ?

Yes, already reported a while ago. I was having this problem with ls in
large directories where it sometimes took more than 10 seconds to scroll.
It is clearly a scheduler problem, but most people don't seem concerned
by this one since the most important to their ears is that xmms should not
skip during make -j $UINT_MAX :-/ It's a bit of a shame since other than
that, it seems stable enough for daily use on a desktop, but this problem
is too much annoying for me to definitely switch to 2.6. I wanted to give
a try to Nick's scheduler, but didn't have time yet.

Regards,
Willy


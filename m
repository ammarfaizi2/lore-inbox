Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264424AbUEaNfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbUEaNfX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUEaNfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:35:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47810 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264424AbUEaNfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:35:07 -0400
Date: Thu, 27 May 2004 23:03:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Brian Gerst <bgerst@didntduck.org>, willy@w.ods.org, arjanv@redhat.com,
       hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i486 emu in mainline?
Message-ID: <20040527210346.GC997@openzaurus.ucw.cz>
References: <40B0DB49.3090308@quark.didntduck.org> <E1BS5V8-0006d6-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BS5V8-0006d6-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> It was intentional for speed purpose. The areas are checked once with
> >> verify_area() when we need to access memory, then data is copied directly
> >> from/to memory. I don't think there's any risk, but I can be wrong.
> > 
> > Which will break with 4G/4G.  You must use at least __get_user().
> 
> A 386 with a 4G/4G split, I'd like to see that.

I believe you could...

1) some 586 class machines do not know 486 opcodes

2) this is for rescue kernel. If you want to be able to rescue 64GB machine *and* rescue 486 too,
this+4G/4G is right choice ;-)

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265886AbUGIVy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUGIVy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUGIVy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:54:28 -0400
Received: from colin2.muc.de ([193.149.48.15]:33800 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265886AbUGIVyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:54:18 -0400
Date: 9 Jul 2004 23:54:15 +0200
Date: Fri, 9 Jul 2004 23:54:15 +0200
From: Andi Kleen <ak@muc.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040709215415.GA56272@muc.de>
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it> <2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it> <2fPfF-2Dv-19@gated-at.bofh.it> <m34qohrdel.fsf@averell.firstfloor.org> <20040709184050.GR28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709184050.GR28324@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Runtime errors caused with gcc 3.4 are IMHO much worse than such a small 
> improvement or three dozen compile errors with gcc 3.4 .

What runtime errors? 

Actually requiring inlining is extremly rare and such functions should
get that an explicit always inline just for documentation purposes.
(another issue is not optimized away checks, but that shows at link time) 

In the x86-64 case it was vsyscalls, in Nigel's case it was swsusp.
Both are quite exceptional in what they do.

> Wouldn't it be a better solution if you would audit the existing inlines 
> in the kernel for abuse of inline and fix those instead?

I don't see any point in going through ~1.2MLOC of code by hand
when a compiler can do it for me.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTD3Nd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 09:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTD3Nd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 09:33:56 -0400
Received: from mx01.arcor-online.net ([151.189.8.96]:62392 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id S262177AbTD3Ndz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 09:33:55 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Wed, 30 Apr 2003 15:51:54 +0200
User-Agent: KMail/1.5.1
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <200304300446.24330.dphillips@sistina.com> <20030430071907.GA30999@alpha.home.local>
In-Reply-To: <20030430071907.GA30999@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304301551.54138.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 April 2003 09:19, Willy Tarreau wrote:
> Oh, and the new2 function is another variant I have been using by the past,
> but it is slower here.

It's really cute.

> It performed well on older machines with gcc 2.7.2.
> Its main problem may be the code size, due to the 32 bits masks. Your code
> has the advantage of being short and working on small data sets.

My code just looks small.  At -O2 it expands to 4 times the size of the 
existing fls and 5 times at -O3.  The saving grace is that, being faster, it 
doesn't have to be inline, saving code size overall.

> [code]
>
> Here are the results...

The overall trend seems to be that my version is faster with newer compilers 
and higher optimization levels, and overall, the newer compilers are 
producing faster code.  The big anomally is where the original version turns 
in the best time of the lot, running on PIV, compiled at -O3 with 2.95.3, as 
you pointed out.

Well, it raises interesting questions, but I'm not entirely sure what they are 
;-)

Regards,

Daniel


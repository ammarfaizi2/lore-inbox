Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWEOLqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWEOLqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 07:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWEOLqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 07:46:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50598 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964893AbWEOLqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 07:46:30 -0400
From: Andi Kleen <ak@suse.de>
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Subject: Re: Segfault on the i386 enter instruction
Date: Mon, 15 May 2006 13:46:21 +0200
User-Agent: KMail/1.9.1
Cc: Tomasz Malesinski <tmal@mimuw.edu.pl>, linux-kernel@vger.kernel.org
References: <20060512131654.GB2994@duch.mimuw.edu.pl> <20060512153139.GA4852@duch.mimuw.edu.pl> <446867C4.3070108@etpmod.phys.tue.nl>
In-Reply-To: <446867C4.3070108@etpmod.phys.tue.nl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605151346.21877.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> http://groups.google.co.nz/groups?selm=7i86ni%24b7n%241%40palladium.transmeta.com

Linus' reasoning is actually outdated - on most modern x86s it is not
slower than the expanded code sequence because it will generate the
same number of macro/u-ops. But it would be still extremly ugly to 
implement, which is a good reason not to.

> And perhaps x86-64 is handled different because of the red zone (some
> memory below the stack-pointer that can be accessed legally)?

Yes, but it's only 128 bytes so it won't help for larger frames.
It will also work if you preextended the stack before, but i wouldn't
rely on it.

-Andi

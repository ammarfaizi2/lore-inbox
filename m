Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUGHPaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUGHPaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUGHPaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:30:08 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:2008 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263831AbUGHPaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:30:04 -0400
Date: Thu, 8 Jul 2004 16:30:07 +0100 (BST)
From: "P. Benie" <pjb1008@eng.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <87hdsih7d9.fsf@sanosuke.troilus.org>
Message-ID: <Pine.HPX.4.58L.0407081601580.28859@punch.eng.cam.ac.uk>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
 <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.53.0407080707010.21439@chaos>
 <Pine.HPX.4.58L.0407081224460.28859@punch.eng.cam.ac.uk>
 <Pine.LNX.4.53.0407081030320.21855@chaos> <87hdsih7d9.fsf@sanosuke.troilus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2004, Michael Poole wrote:
> Could you please elaborate the rules of English in which "An integer
> constant expresion with the value 0 [...] is called a null pointer
> constant" does not mean that 0 is a null pointer?  0 is certainly an
> integer constant expression with the value 0, so there must be
> something extraordinarily subtle in the second half of the sentence.

He's emphasising the difference between "null pointer constant"  and "null
pointer", however NULL is defined as "an implementation-defined null
pointer constant", so any subtle issues regarding 0 apply equally well to
NULL.

Someone pointed out that there can be a difference between 0 and NULL when
passing the value to a function lacking a prototype. There's no guarantee
that the null pointers of different types have the same representation, so
passing NULL into such a function without an explicit cast would also be
incorrect.

Peter

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUGHLnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUGHLnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 07:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUGHLnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 07:43:14 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:34301 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261169AbUGHLnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 07:43:13 -0400
Date: Thu, 8 Jul 2004 12:43:16 +0100 (BST)
From: "P. Benie" <pjb1008@eng.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <Pine.LNX.4.53.0407080707010.21439@chaos>
Message-ID: <Pine.HPX.4.58L.0407081224460.28859@punch.eng.cam.ac.uk>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
 <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.53.0407080707010.21439@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2004, Richard B. Johnson wrote:
> On Thu, 8 Jul 2004, Herbert Xu wrote:
> > What's wrong with using 0 as the NULL pointer?
>
> Because NULL is a valid pointer value. 0 is not. If you were
> to make 0 valid, you would use "(void *)0", which is what
> NULL just happens to be in all known architectures so far,
> although that could change in an alternate universe.

False. "An integer constant expressions with the value 0, or such an
expression cast to type void *, is called a null pointer constant. If a
null pointer constant is assigned to or compared for equality with a
pointer, the constant is converted to a pointer of that type", and "Any
two null pointers shall compare equal."

In other words, when you use 0 as a null pointer, you really do get a null
pointer. If you are working on an architecture where the bit pattern of
the integer 0 and null pointers are not the same, the compiler will
perform the appropriate conversion for you, so it is always correct to
define NULL as (void *)0.

Personally, I always use 0 and NULL for integers and null pointers
respectively, but that's because of long estalished conventions that make
the code readabile, rather than anything to do with validity of the code.

Peter

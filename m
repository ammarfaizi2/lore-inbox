Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbTEGVOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTEGVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:14:46 -0400
Received: from infa.abo.fi ([130.232.208.126]:47366 "EHLO infa.abo.fi")
	by vger.kernel.org with ESMTP id S264223AbTEGVOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:14:45 -0400
Date: Thu, 8 May 2003 00:27:01 +0300
From: Marcus Alanen <marcus@infa.abo.fi>
Message-Id: <200305072127.h47LR1Z14629@infa.abo.fi>
To: rddunlap@osdl.org, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <20030507133856.02748f4e.rddunlap@osdl.org>
References: <3EB95BD7.8060700@pobox.com> <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <1052332566.752437@palladium.transmeta.com> <3EB95BD7.8060700@pobox.com> <20030507133856.02748f4e.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 13:38:56 -0700, Randy.Dunlap <rddunlap@osdl.org> wrote:
>I have mostly used kmalloc/kfree, but using automatic variables is certainly
>cleaner to write (code).  One of the patches that I did just made each ioctl
>cmd call a separate function, and then each separate function was able to use
>automatic variables on the stack instead of kmalloc/kfree.  I prefer this
>method when it's feasible (and until gcc can handle these cases).

I take it moving the automatic variables in the function to a static
data area would be possible, _if_ that function (or rather, the
variables) is protected by some unique lock (not some per-structure
lock, of course)? Although this is probably already done in the
majority of cases.

Marcus


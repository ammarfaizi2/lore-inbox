Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWEJD3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWEJD3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWEJD3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 23:29:08 -0400
Received: from lixom.net ([66.141.50.11]:59043 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S964781AbWEJD3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 23:29:07 -0400
Date: Tue, 9 May 2006 22:29:12 -0500
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] mtd redboot (also gcc 4.1 warning fix)
Message-ID: <20060510032912.GC1794@lixom.net>
References: <200605100256.k4A2u4FO031737@dwalker1.mvista.com> <305c16960605092014t240ece2ob620264501deaa39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960605092014t240ece2ob620264501deaa39@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 12:14:45AM -0300, Matheus Izvekov wrote:
> On 5/9/06, Daniel Walker <dwalker@mvista.com> wrote:
> >unsigned long may not always be 32 bits, right ? This patch fixes the
> Incorrect, its defined as 32bits for every standard C compiler

Wrong. The only environment I'm aware of that has only P64 is Win64.

Still, that's a bad patch, since it removes the warning without fixing
the bug. It's a valid warning, the underlying problem should be fixed
instead. It's better to keep the warning around until that's been done.


-Olof

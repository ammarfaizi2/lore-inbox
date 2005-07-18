Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVGRUYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVGRUYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 16:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVGRUYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 16:24:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50823
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261601AbVGRUYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 16:24:23 -0400
Date: Mon, 18 Jul 2005 13:24:44 -0700 (PDT)
Message-Id: <20050718.132444.78737368.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: ast@domdv.de, linux-kernel@vger.kernel.org, jmorris@intercode.com.au
Subject: Re: 2.6.13rc3: crypto horribly broken on all 64bit archs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050717204554.GA23637@gondor.apana.org.au>
References: <42DA4D05.7000403@domdv.de>
	<20050717204554.GA23637@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 18 Jul 2005 06:45:54 +1000

> On Sun, Jul 17, 2005 at 02:20:21PM +0200, Andreas Steinmetz wrote:
> > 
> > The compiler first does ~((a)-1)) and then expands the unsigned int to
> > unsigned long for the & operation. So we end up with only the lower 32
> > bits of the address. Who did smoke what to do this? Patch attached.
> 
> Thanks for the patch Andreas.  A similar patch will be in the
> mainline kernel as soon as everybody is back home from Canada.

Yes, the fix is in my tree and will make it's way upstream
as soon as possible.

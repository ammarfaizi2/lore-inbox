Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbUJZCaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbUJZCaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbUJZCaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:30:08 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:13164 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262220AbUJZC0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:26:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=N0ceY+ATJWmIGKzYRfbD13XHWx7eo8N9GEHFtOuxFKqyAUGKzwFg3GDZ27QGqQyyjGl26LO869Py+LaIj2GmlartOyCz31v4qs4O87CZCZHwawWu1ZOQqThTH8vIwQbB6W0qrNXNSm7Dj2FSEx/AWZq4+AVTeSiFHjly5TXMXtA=
Message-ID: <9e473391041025192622ddfee3@mail.gmail.com>
Date: Mon, 25 Oct 2004 22:26:37 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <20041025230128.GA1232@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041023161253.GA17537@work.bitmover.com>
	 <20041024144448.GA575@work.bitmover.com>
	 <4d8e3fd304102409443c01c5da@mail.gmail.com>
	 <20041024233214.GA9772@work.bitmover.com>
	 <20041025114641.GU14325@dualathlon.random>
	 <1098707342.7355.44.camel@localhost.localdomain>
	 <20041025133951.GW14325@dualathlon.random>
	 <20041025162022.GA27979@work.bitmover.com>
	 <9e47339104102511182f916705@mail.gmail.com>
	 <20041025230128.GA1232@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004 16:01:28 -0700, Larry McVoy <lm@bitmover.com> wrote:
> As for digital signatures, we quietly added that a long time ago,
> every push by Linus or Marcelo to bkbits.net is digitally signed twice,

Would it be useful for BK to provide more detailed tracking of who
made what changes to the kernel?

For example  a digital signature trail on change sets that tracks who did
what. Say I do some changes on my local tree, export it and
mail it out on lkml. This change set is picked up by Andrew. Andrew
munges on it some and sends it onto Linus. Linus changes another
couple of lines and puts it in his tree.  Now I go to bkbits and look
at the history for the lines changed. Can I see what Linus, Andrew and
I have all changed including digital signatures?

The final change set going into linus' tree would have to embed my
orginal change set intact but hidden since it is signed by me and
Linus doesn't have my key.  Andrew's and Linus' changes would be added
as signed diffs against my original change set.

You would also need a scheme to import signed diffs and preserve the
signature for non-bk users.

This would automate the "Signed off by" process. It would also much
more accurately track who did what to the tree.

-- 
Jon Smirl
jonsmirl@gmail.com

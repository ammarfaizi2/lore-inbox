Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271731AbTGRHQu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 03:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271732AbTGRHQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 03:16:49 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:1544 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S271731AbTGRHQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 03:16:43 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>
Subject: Re: SET_MODULE_OWNER
Date: Fri, 18 Jul 2003 09:31:39 +0200
User-Agent: KMail/1.5.2
Cc: schlicht@uni-mannheim.de, ricardo.b@zmail.pt, linux-kernel@vger.kernel.org
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net> <20030717125942.7fab1141.davem@redhat.com> <3F170589.50005@pobox.com>
In-Reply-To: <3F170589.50005@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307180931.39177.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 July 2003 22:22, Jeff Garzik wrote:
> David S. Miller wrote:
> > On Thu, 17 Jul 2003 12:00:58 -0400
> >
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> >>David?  Does Rusty have a plan here or something?
> >
> > It just works how it works and that's it.
> >
> > Net devices are reference counted, anything more is superfluous.
> > They may be yanked out of the kernel whenever you want.
>
> (I'm obviously just realizing the implications of this... missed it
> completely during the earlier discussions)
>
> Object lifetime is just part of the story.
>
> This change is a major behavior change.  The whole point of removing a
> module is knowing its gone ;-)  And that is completely changed now.
> Modules are very often used by developers in a "modprobe ; test ; rmmod"
> cycle, and that's now impossible (you don't know when the net device,
> and thus your code, is really gone).  It's already breaking userland,
> which does sweeps for zero-refcount modules among other things.

Most USB drivers can be unloaded at any time, so this problem already
existed elsewhere.

Duncan.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUIPBWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUIPBWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 21:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUIPBW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 21:22:29 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:9183 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267401AbUIPBVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 21:21:05 -0400
Date: Thu, 16 Sep 2004 03:21:04 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Robert Love <rml@novell.com>
Cc: Tim Hockin <thockin@hockin.org>, Greg KH <greg@kroah.com>,
       Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040916012104.GA21832@MAIL.13thfloor.at>
Mail-Followup-To: Robert Love <rml@novell.com>,
	Tim Hockin <thockin@hockin.org>, Greg KH <greg@kroah.com>,
	Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <1095279985.23385.104.camel@betsy.boston.ximian.com> <20040915203133.GA18812@hockin.org> <1095280414.23385.108.camel@betsy.boston.ximian.com> <20040915204754.GA19625@hockin.org> <1095281358.23385.109.camel@betsy.boston.ximian.com> <20040915205643.GA19875@hockin.org> <20040915212322.GB25840@kroah.com> <1095283589.23385.117.camel@betsy.boston.ximian.com> <20040915213419.GA21899@hockin.org> <1095284320.23385.123.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095284320.23385.123.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 05:38:39PM -0400, Robert Love wrote:
> On Wed, 2004-09-15 at 14:34 -0700, Tim Hockin wrote:
> 
> > It's a can of worms, is what it is.  And I'm not sure what a good fix
> > would be.  Would it just be enough to send a generic "mount-table changed"
> > event, and let userspace figure out the rest?
> 
> "Can of worms" is a tough description for something that there is no
> practical security issue for, just a lot of hand waving.  No one even
> uses name spaces.

ah, sorry, that is wrong, we (linux-vserver)
_do_ use namespaces extensively, and probably 
other 'jail' solutions will use it too ...

best,
Herbert

> Anyhow, I already said that we could send out a generic kobject instead
> of the one tied to the specific device.
> 
> > Or really, why is the kernel broadcasting a mount, which originated in
> > userland.  Couldn't mount (or a mount wrapper) do that?  It's already
> > running in the right namespace...
> 
> In practice stuff like that never works.  Besides, it is not mount(1)
> that we want to wrap but the mount(2) system call.  And, uh, I'd rather
> stab myself than try to get that patch by Uli.
> 
> 	Robert Love
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

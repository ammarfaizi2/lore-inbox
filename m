Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTLBUxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbTLBUxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:53:21 -0500
Received: from mx1.verat.net ([217.26.64.139]:56012 "EHLO mx1.verat.net")
	by vger.kernel.org with ESMTP id S264343AbTLBUxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:53:19 -0500
From: snpe <snpe@snpe.co.yu>
To: Linus Torvalds <torvalds@osdl.org>, Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Linux 2.4 future
Date: Tue, 2 Dec 2003 19:59:53 +0000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <20031202063912.GD16507@lug-owl.de> <Pine.LNX.4.58.0312020956120.1519@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312020956120.1519@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312021959.53095.snpe@snpe.co.yu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone work on transfer linux-abi to kernel 2.6 ?
regards
On Tuesday 02 December 2003 06:04 pm, Linus Torvalds wrote:
> On Tue, 2 Dec 2003, Jan-Benedict Glaw wrote:
> > On Tue, 2003-12-02 02:23:55 +0000, snpe <snpe@snpe.co.yu>
> >
> > wrote in message <200312020223.55505.snpe@snpe.co.yu>:
> > > Is there linux-abi for 2.6 kernel ?
> >
> > Nobody really cares about ABI (at least, not enough to keep one stable)
> > while there's a good API. That requires sources, though, but that's a
> > good thing...
>
> People care _deeply_ about the user-visible Linux ABI - I personally think
> backwards compatibility is absolutely _the_ most important issue for any
> kernel, and breaking user-land ABI's is simply not done.
>
> Sometimes we tweak user-visible stuff (for example, removing truly
> obsolete system calls), but even then we're very very careful. Like
> printing out warning messages for several _years_ before actually removing
> the functionality.
>
> The one exception tends to be "system management" ABI's, ie stuff that
> normal programs don't use. So kernel updates do sometimes require new
> utilities for doing things like firewall configuration, hardware setup
> (ethernet tools, ifconfig etc), or - in the case of 2.6 - module loading
> and unloading. Even that is frowned upon, and there has to be a good
> reason for it.
>
> At times, we've modified semantics of existing system behaviour subtly:
> either to conform to standards, or because of implementation issues. It
> doesn't happen often, and if it is found to break existing applications it
> is not done at all (and the thing is fixed by adding a new system call
> with the proper semantics, and leaving the old one broken).
>
> You are, however, correct when it comes to internal kernel interfaces: we
> care not at all about ABI's, and even API's are fluid and are freely
> changed if there is a real technical reason for it. But that is only true
> for the internal kernel stuff (where source is obviously a requirement
> anyway).
>
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


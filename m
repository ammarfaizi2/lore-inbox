Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267587AbUHTRW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUHTRW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUHTRW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:22:26 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:42841 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268342AbUHTRWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:22:21 -0400
Date: Fri, 20 Aug 2004 21:22:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jon Anderson <jon-anderson@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: vmlinuz no symtab? while cross compiling...
Message-ID: <20040820192244.GA7298@mars.ravnborg.org>
Mail-Followup-To: Jon Anderson <jon-anderson@rogers.com>,
	linux-kernel@vger.kernel.org
References: <41244A9F.70109@rogers.com> <20040819220420.GB7440@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819220420.GB7440@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 12:04:20AM +0200, Sam Ravnborg wrote:
> On Thu, Aug 19, 2004 at 02:37:19AM -0400, Jon Anderson wrote:
> > I'm attempting to cross compile linux-2.6.8.1, along with a few external 
> > modules (madwifi, hostap-driver, aodv-uu). The kernel and (built-in) 
> > modules compile fine, but compiling every one of those external modules 
> > fails around MODPOST. For example, aodv-uu:
> 
> Took a look at aodv-uu.
> Author should learn to create a real Kbuild Makefile...
> But that does not seem to be your problem.
Actually it was not that bad for 2.6 - but 2.4 could use some help.

> > modpost: vmlinux no symtab?
> modpost complains that it cannot locate the symbol table in vmlinux.
> That can be caused by the following reasons:
> 
> o vmlinux were build with different settings than scripts/mod
>   - If you cleaned out scripts/mod/ and run make scripts with wrong ARCH options
> o vmlinux has been stripped for some reason

The last item on the list was the culprint in this case.

	Sam

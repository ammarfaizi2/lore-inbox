Return-Path: <linux-kernel-owner+w=401wt.eu-S1751011AbWLMVPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWLMVPx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWLMVPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:15:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51806 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbWLMVPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:15:53 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <Pine.LNX.4.64.0612131306460.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <20061213203113.GA9026@suse.de>
	 <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
	 <Pine.LNX.4.64.0612131306460.5718@woody.osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 13 Dec 2006 22:15:47 +0100
Message-Id: <1166044547.27217.902.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 13:08 -0800, Linus Torvalds wrote:
> 
> On Wed, 13 Dec 2006, Linus Torvalds wrote:
> > 
> > Btw: there's one driver we _know_ we want to support in user space, and 
> > that's the X kind of direct-rendering thing. So if you can show that this 
> > driver infrastructure actually makes sense as a replacement for the DRI 
> > layer, then _that_ would be a hell of a convincing argument.
> 
> Btw, the other side of this argument is that if a user-space driver 
> infrastructure can _not_ help the DRI kind of situation, then it's largely 

with DRI you have the case where "something" needs to do security
validation of the commands that are sent to the card. (to avoid a
non-privileged user to DMA all over your memory)

That and a tiny bit of resource management is the bulk of the kernel DRM
code... and I don't think userspace can do it fundamentally better.
Sure you could pipe things to a root daemon instead of doing a system
call. But I don't see that being superior.


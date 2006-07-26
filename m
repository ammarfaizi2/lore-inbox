Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWGZRn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWGZRn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWGZRn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:43:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030345AbWGZRn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:43:28 -0400
Date: Wed, 26 Jul 2006 10:43:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Nasty git corruption problem
In-Reply-To: <Pine.LNX.4.64.0607261039380.29649@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0607261041490.29649@g5.osdl.org>
References: <1153929715.13509.12.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607260945440.29649@g5.osdl.org>
 <Pine.LNX.4.63.0607261935160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607261039380.29649@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jul 2006, Linus Torvalds wrote:
> On Wed, 26 Jul 2006, Johannes Schindelin wrote:
> >
> > We _do_ have git-lost-found.sh.
> 
> Yeah, sure, I knew that, I was just checking who was awake..

Actually, now that I actually look at it, I notice that it doesn't pass in 
"--full" to git-fsck-objects, so it doesn't actually work that well in the 
presense of dangling objects that are inside pack-files.

(And if it wasn't already obvious, with my patch you still need to do 
"git-fsck-objects --full --lost-n-found" if you want to look inside those 
pack-files, but at least it's an option you can enable).

			Linus

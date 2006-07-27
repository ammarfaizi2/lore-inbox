Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751952AbWG0THn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWG0THn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbWG0THn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:07:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13493 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751952AbWG0THm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:07:42 -0400
Date: Thu, 27 Jul 2006 12:07:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Nasty git corruption problem
In-Reply-To: <1154025127.13509.90.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607271206461.4168@g5.osdl.org>
References: <1153929715.13509.12.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607260945440.29649@g5.osdl.org> 
 <Pine.LNX.4.63.0607261935160.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0607261039380.29649@g5.osdl.org>  <Pine.LNX.4.64.0607261041490.29649@g5.osdl.org>
 <1154025127.13509.90.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jul 2006, Alan Cox wrote:
> 
> git-lost-found turns up some of the missing stuff that was applied
> earliest in the rebase but the other stuff is apparently neither visible
> anywhere in the tree or missing (the tree I was rebasing "^^^..." never
> shows it nor does the log).

Did you try "git-fsck-objects --full"?

The git-lost-found script is apparently broken, exactly because it doesn't 
do a "full".

		Linus

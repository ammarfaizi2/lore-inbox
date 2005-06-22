Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVFVAWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVFVAWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVFVATP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:19:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262384AbVFVAOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:14:39 -0400
Date: Tue, 21 Jun 2005 17:13:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
In-Reply-To: <42B8A8CA.9040804@pobox.com>
Message-ID: <Pine.LNX.4.58.0506211709220.2353@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506211304320.2915@skynet>
 <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com>
 <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org> <42B84E20.7010100@pobox.com>
 <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org> <42B8542A.9020700@pobox.com>
 <Pine.LNX.4.58.0506211103370.2268@ppc970.osdl.org> <42B859B4.5060209@pobox.com>
 <Pine.LNX.4.58.0506211124310.2268@ppc970.osdl.org> <42B8A82E.4020207@pobox.com>
 <42B8A8CA.9040804@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Jun 2005, Jeff Garzik wrote:
> Jeff Garzik wrote:
> 
> It does seem to hit the final branch in the script:
> 
> > [jgarzik@pretzel libata-dev]$ sh -x /usr/local/bin/git-checkout-script -f ncq
> > + new=d032ec9048ff82a704b96b93cfd6f2e8e3a06b19
> > + '[' -f .git/revs/heads/ncq ']'

Oops. Typo of mine. "revs" is incorrect, it should be "refs".

So because it's testing the wrong directory for the branch name, it
obviously won't find the branch, and decides that you used just a regular 
commit name.

I bet that one-character fix will fix it. Pushed out, 

		Linus

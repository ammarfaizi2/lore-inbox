Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTJJQqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbTJJQqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:46:12 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:23559 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S263008AbTJJQqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:46:07 -0400
Date: Fri, 10 Oct 2003 12:45:59 -0400
To: Michael Shuey <shuey@fmepnet.org>
Cc: trond.myklebust@fys.uio.no, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Misc NFSv4 (was Re: statfs() / statvfs() syscall ballsup...)
Message-ID: <20031010164559.GG20755@fieldses.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org> <20031010143553.GA28795@mail.shareable.org> <16262.53512.249701.158271@charged.uio.no> <200310101055.12626.shuey@fmepnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310101055.12626.shuey@fmepnet.org>
User-Agent: Mutt/1.3.28i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 10:55:10AM -0500, Michael Shuey wrote:
> On Friday 10 October 2003 10:32 am, Trond Myklebust wrote:
> > The client implementation in 2.6.0 is still lacking several important
> > features, including locking, ACLs, delegation support and recovery of
> > state (in case of server reboot or network partitions). I'm hoping
> > Andrew/Linus will allow me to send updates once the early 2.6.x
> > codefreeze period is over.
> 
> How about other features?  In particular, do the client/server do 
> authentication (krb5? lipkey/spkm3?), integrity and privacy?

The client has krb5 authentication support, the server doesn't.  Patches
are available from the citi web page for server-side authentication and
client-side integrity.

> Also, are any patches on Citi's site useful anymore?

The test1 patches probably apply (possibly with some manual
intervention) up to about test6.  At least one of them (the first gss
patch) is a fairly critical bugfix.  I'm just updating to test7 myself
right now; I'll try to post new patches soon, but in the worst case it
might not be till after we get back from testing at Connectathon (in two
weeks).

--Bruce Fields

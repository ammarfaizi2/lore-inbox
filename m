Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWFUNkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWFUNkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWFUNkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:40:46 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:1542 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S932151AbWFUNkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:40:45 -0400
Date: Wed, 21 Jun 2006 21:39:25 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
cc: autofs mailing list <autofs@linux.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
In-Reply-To: <20060620233941.49ba2223.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606212135540.14481@raven.themaw.net>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
 <20060620233941.49ba2223.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 5, autolearn=not spam)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Andrew Morton wrote:

> 
> Also, did you consider broadening the ->d_revalidate() semantics?  It
> appears that all implementations return 0 or 1.  You could teach the VFS to
> also recognise and act upon a -ve return value, and do this trickery within
> the autofs d_revalidate(), perhaps?
> 

Now it occurs to me this is the only safe way to do this.
And a lot simpler.

Al, given this is such a heavily traveled piece of code, do you think 
it would be acceptable to change the semantics of revalidate in this way.

Ian


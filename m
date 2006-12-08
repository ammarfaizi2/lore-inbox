Return-Path: <linux-kernel-owner+w=401wt.eu-S1425526AbWLHOsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425526AbWLHOsZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425527AbWLHOsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:48:25 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:61566 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425526AbWLHOsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:48:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P9OxzFrP+jXRAOh0svOiWuT9WRHJXscwYKFbOuLGfllBGZYBXAolVxGskf/BNe2lI6Gw3MzdPtsMn9s5Y2n1VUokLcs8+QP1ToggcNn9On61UzyPk95rOd6AwDr3cXplwha2Cs40K70hCpJl5OjxWhIkvpPID3/YFrkb6TLRaVc=
Message-ID: <9a8748490612080648l427000a7ue613d8b124cc628e@mail.gmail.com>
Date: Fri, 8 Dec 2006 15:48:24 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: Let's get rid of those annoying "VFS is out of sync with lock manager" messages (includes proposed patch)
Cc: linux-kernel@vger.kernel.org,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       nfs@lists.sourceforge.net
In-Reply-To: <9a8748490612080635o3432d410gbb147c977de21499@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612072208.16350.jesper.juhl@gmail.com>
	 <17784.56763.794504.185193@cse.unsw.edu.au>
	 <9a8748490612080635o3432d410gbb147c977de21499@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 08/12/06, Neil Brown <neilb@suse.de> wrote:
> > On Thursday December 7, jesper.juhl@gmail.com wrote:
> > >
> > > So I took Neils patch, made the change Trond suggested and the result is
> > > below.
> > >
> > > Comments?  Ok to merge?
> >
> > Yes, except that you need a changelog comment at the top.  Possibly
> > based very heavily on the text I wrote, but written to justify the
> > patch rather than to explain the bug.
> >
> > NeilBrown
> >
>
> How about this for a changelog entry?  :
>
> Convert "VFS is out of sync with lock manager!" printk in
> do_vfs_lock() to dprintk() since the message is useless in normal use
> but could possibly be useful as a debugging aid.
> Also turn off FL_SLEEP when calling do_vfs_lock() just in case after
> getting -EINTR or -ERESTARTSYS.
>
>
Ohh and btw, I forgot to mention that the patch has been tested and
resolves my original issue.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

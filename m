Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWCZLfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWCZLfj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 06:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWCZLfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 06:35:39 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:5493 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751265AbWCZLfi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 06:35:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MOLKOsaq1pHbT4m8YvEjk5TIMgbXGWMzqH9FWlejagQjxmX62bFFXa5NUHfdkjPfuVUsrkEk4fNR5ndsKlhjy+8Bk7SSWubj49okQOoR10DC82wgTti3h4MmN7a5Ac+cPBR4taNbI9exn7Z3PfW3WbZcwVzWe8s8C1wbx1j+ELo=
Message-ID: <9a8748490603260335g4e527ae9had20de42041c3983@mail.gmail.com>
Date: Sun, 26 Mar 2006 13:35:37 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Per Liden" <per.liden@ericsson.com>
Subject: Re: [PATCH] cleanup for net/tipc/name_distr.c::tipc_named_node_up()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603221049140.6949@ulinpc219.uab.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603190045.24176.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603221049140.6949@ulinpc219.uab.ericsson.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/06, Per Liden <per.liden@ericsson.com> wrote:
> On Sun, 19 Mar 2006, Jesper Juhl wrote:
>
> > Small cleanup patch for net/tipc/name_distr.c::tipc_named_node_up()
>
> Not sure if you followed the discussion on the tipc mailinglist, so here's
> a short summary.
>
I don't read the tipc mailing list, no.


> > Patch does the following:
> >
> >  - Change a few pointer assignments from 0 to NULL (makes sparse happy).
>
> Ok.
>
> >  - Move a few variable assignment outside the tipc_nametbl_lock lock.
>
> Ok.
>

Do you want a new patch with just these bits in it or will you take
care of it yourself?


> >  - Make sure to free the allocated buffer before returning so we don't leak.
>
> The additional kfree_skb() looks incorrect. If a buffer if allocated it
> will later be released by tipc_link_send().
>
I see. Then that bit is indeed incorrect.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

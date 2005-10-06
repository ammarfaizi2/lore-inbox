Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVJFSP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVJFSP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVJFSP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:15:28 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:25356 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751279AbVJFSP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:15:28 -0400
To: jamie@shareable.org
CC: trond.myklebust@fys.uio.no, miklos@szeredi.hu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20051006175940.GA19766@mail.shareable.org> (message from Jamie
	Lokier on Thu, 6 Oct 2005 18:59:40 +0100)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu> <1128616864.8396.32.camel@lade.trondhjem.org> <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu> <1128618447.8396.39.camel@lade.trondhjem.org> <E1ENZTJ-0003Mm-00@dorka.pomaz.szeredi.hu> <1128620196.16534.20.camel@lade.trondhjem.org> <20051006175940.GA19766@mail.shareable.org>
Message-Id: <E1ENaFI-0003W9-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 06 Oct 2005 20:13:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think Miklos' point is that it's not an "optimisation" because it's
> not optional.  Optimisations are things where if you don't do them,
> the behaviour is still correct but slower.
> 
> As far as I can tell from this discussion, the atomic lookup+create is
> a non-optional requirement.

Exactly.

Trond, you wrote this in an earlier discussion:

> > so the filesystem can delay returning the error from the open
> > operation until the other errors have been sorted out by the lookup
> > code.
> 
> Intents are meant as optimisations, not replacements for existing
> operations. I'm therefore not really comfortable about having them
> return errors at all.

The case I described is not an optimization, so in that case you seem
to agree, that lookup intents are not the solution.

Miklos

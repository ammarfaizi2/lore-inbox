Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVJFR7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVJFR7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJFR7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:59:49 -0400
Received: from mail.shareable.org ([81.29.64.88]:63197 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1751266AbVJFR7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:59:49 -0400
Date: Thu, 6 Oct 2005 18:59:40 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] atomic create+open
Message-ID: <20051006175940.GA19766@mail.shareable.org>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu> <1128616864.8396.32.camel@lade.trondhjem.org> <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu> <1128618447.8396.39.camel@lade.trondhjem.org> <E1ENZTJ-0003Mm-00@dorka.pomaz.szeredi.hu> <1128620196.16534.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128620196.16534.20.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> > Earlier you said, that intents are meant to be optional, so this
> > atomicity requirement is getting further from the "intent" concept.
> 
> No it is not. It is bang right in the middle of the intent concept.
> 
> Intents are there in order to allow the filesystem to determine which
> operation is calling lookup so that it can optimise for that particular
> operation.

I think Miklos' point is that it's not an "optimisation" because it's
not optional.  Optimisations are things where if you don't do them,
the behaviour is still correct but slower.

As far as I can tell from this discussion, the atomic lookup+create is
a non-optional requirement.

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbUFGQjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUFGQjX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUFGQjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:39:23 -0400
Received: from mail.ccur.com ([208.248.32.212]:54540 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264933AbUFGQjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:39:22 -0400
Date: Mon, 7 Jun 2004 12:39:20 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, Ronny.Lampert@telecasystems.de,
       ioe-lkml@rameria.de
Subject: Re: [BUG] NFS no longer updates file modification times appropriately
Message-ID: <20040607163920.GB22505@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1086625209.4597.0.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086625209.4597.0.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 12:20:11PM -0400, Trond Myklebust wrote:
> P? m? , 07/06/2004 klokka 12:13, skreiv Joe Korty:
> > > 
> > > >   In which case we
> > > > could defer a timestamp-on-write only when it is still in the same second
> > > > as the previous write, but don't defer when a new second rolls around
> > > > on the client.  That would reduce timestamp updates to at most one per
> > > > second per inode per client, while preserving old NFS behavior.
> > > 
> > > Exactly why should we go to all this trouble?
> > 
> > For compatibility?
> 
> With what? There has never been a standard other than the close-to-open.

Compatibility with existing behavior.  It's called a de-facto standard.

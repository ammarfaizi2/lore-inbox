Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUFGQNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUFGQNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbUFGQNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:13:08 -0400
Received: from mail.ccur.com ([208.248.32.212]:57092 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264902AbUFGQNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:13:05 -0400
Date: Mon, 7 Jun 2004 12:13:04 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, Ronny.Lampert@telecasystems.de,
       ioe-lkml@rameria.de
Subject: Re: [BUG] NFS no longer updates file modification times appropriately
Message-ID: <20040607161304.GA22505@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1086623509.4173.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086623509.4173.7.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 11:51:49AM -0400, Trond Myklebust wrote:
> P? m? , 07/06/2004 klokka 11:21, skreiv Joe Korty:
> > Unless the real reason is reducing ethernet traffic.
> 
> That is after all, why we cache data. Look at the GETATTR traffic using
> nfsstat.
> 
> >   In which case we
> > could defer a timestamp-on-write only when it is still in the same second
> > as the previous write, but don't defer when a new second rolls around
> > on the client.  That would reduce timestamp updates to at most one per
> > second per inode per client, while preserving old NFS behavior.
> 
> Exactly why should we go to all this trouble?

For compatibility?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVEFOmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVEFOmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVEFOmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:42:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4741 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261189AbVEFOmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:42:14 -0400
Date: Fri, 6 May 2005 15:42:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: chas3@users.sourceforge.net
Cc: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>,
       Willy Tarreau <willy@w.ods.org>, openafs-info@openafs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs 1.3.82
Message-ID: <20050506144207.GA2604@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas3@users.sourceforge.net,
	Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>,
	Willy Tarreau <willy@w.ods.org>, openafs-info@openafs.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0505061024070.450@tassadar.physics.auth.gr> <200505061423.j46ENfTG024192@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505061423.j46ENfTG024192@ginger.cmf.nrl.navy.mil>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 10:23:42AM -0400, chas williams - CONTRACTOR wrote:
> In message <Pine.LNX.4.62.0505061024070.450@tassadar.physics.auth.gr>,Dimitris 
> Zilaskos writes:
> >May  6 04:55:29 system kernel: kernel BUG at inode.c:1204!
> 
> looks like you might have one of those kernels with extra bits (in
> particular, i_notify).  please try a later version of afs like 1.3.81.

Btw, we get tons of bugsreports like that lately.  Is there a chance
that the OpenAFS folks could get their act together and stop abusing
internal interfaces all over.  In particular please stop shadowing struct
inode with your own version and use the proper export operations interfaces
if you're searching for an inode on another filesystem instead of the
utterly wrong blind iget().


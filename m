Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbWIAPyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWIAPyK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWIAPyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:54:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:57740 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751672AbWIAPyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:54:08 -0400
Date: Fri, 1 Sep 2006 17:54:07 +0200
From: Olaf Kirch <okir@suse.de>
To: Chuck Lever <chucklever@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 019 of 19] knfsd: Register all RPC programs with portmapper by default
Message-ID: <20060901155407.GC29574@suse.de>
References: <20060901141639.27206.patches@notabene> <1060901043948.27677@suse.de> <76bd70e30609010831m9e80cfav514d60718d35e7d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76bd70e30609010831m9e80cfav514d60718d35e7d5@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 11:31:25AM -0400, Chuck Lever wrote:
> I don't like this.  The idea that multiple RPC services are listening
> on the same port is a total hack.  What other service might use this
> besides NFSACL?

Why do you consider this a hack? I have always felt that librpc requiring
you to open separate ports for every program you register was a poor
design. The RPC header contains the program number, and the RPC code
is fully capable of demuxing incoming requests. So I do not think it is
a hack at all.

And yes, Solaris NFSACL resides on 2049 too.

Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax

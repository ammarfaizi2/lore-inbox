Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUCKP6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUCKP6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:58:08 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:21011 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S261429AbUCKP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:58:05 -0500
Date: Thu, 11 Mar 2004 10:58:01 -0500
To: =?iso-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UID/GID mapping system
Message-ID: <20040311155800.GA18466@fieldses.org>
References: <1078775149.23059.25.camel@luke> <04031009285900.02381@tabby> <1078941525.1343.19.camel@homer> <04031015412900.03270@tabby> <1078958747.1940.80.camel@nidelv.trondhjem.org> <1078993757.1576.41.camel@quaoar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1078993757.1576.41.camel@quaoar>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 09:29:17AM +0100, Søren Hansen wrote:
> ons, 2004-03-10 kl. 23:45 skrev Trond Myklebust:
> > If you really need uid/gid mapping for NFSv2/v3 too, why not just build
> > on the existing v4 upcall/downcall mechanisms?
> 
> Because that would require changes to both ends of the wire. I want this
> to:
> 1. Work for ALL filesystems (NFS, smbfs, ext2(*) etc.)
> 2. Be transparent for the server.

The latter at least you could already do; just modify the v4
upcall and downcall to map between uid's and uid's instead of mapping
between uid's and names.

--Bruce Fields

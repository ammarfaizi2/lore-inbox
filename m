Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUCKQEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbUCKQEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:04:25 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:23315 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S261519AbUCKQCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:02:50 -0500
Date: Thu, 11 Mar 2004 11:02:45 -0500
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       =?us-ascii?Q?=3D=3FCP?= 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UID/GID mapping system
Message-ID: <20040311160245.GB18466@fieldses.org>
References: <1078775149.23059.25.camel@luke> <04031015412900.03270@tabby> <20040310234640.GO1144@schnapps.adilger.int> <04031108083100.05054@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04031108083100.05054@tabby>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 08:08:31AM -0600, Jesse Pollard wrote:
> On Wednesday 10 March 2004 17:46, Andreas Dilger wrote:
> > If the client is trusted to mount NFS, then it is also trusted enough not
> > to use the wrong UID.  There is no "more" or "less" safe in this regard.
> 
> It is only trusted to not misuse the uids that are mapped for that client. If
> the client DOES misuse the uids, then only those mapped uids will be affected.
> UIDS that are not mapped for that host will be protected.
> 
> It is to ISOLATE the penetration to the host that this is done. The server
> will not and should not extend trust to any uid not authorized to that host. 
> This is what the UID/GID maps on the server provide.

You're making an argument that uid mapping on the server could be used
to provide additional security; I agree.

I don't believe you can argue, however, that providing uid mapping on
the client would *decrease* security, unless you believe that mapping
uid's on the client precludes also mapping uid's on the server.

--Bruce Fields

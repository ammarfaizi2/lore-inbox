Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUCJXqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbUCJXqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:46:50 -0500
Received: from moraine.clusterfs.com ([66.246.132.190]:11407 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262878AbUCJXqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:46:43 -0500
Date: Wed, 10 Mar 2004 16:46:40 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: =?iso-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UID/GID mapping system
Message-ID: <20040310234640.GO1144@schnapps.adilger.int>
Mail-Followup-To: Jesse Pollard <jesse@cats-chateau.net>,
	=?iso-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1078775149.23059.25.camel@luke> <04031009285900.02381@tabby> <1078941525.1343.19.camel@homer> <04031015412900.03270@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04031015412900.03270@tabby>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 10, 2004  15:41 -0600, Jesse Pollard wrote:
> On Wednesday 10 March 2004 11:58, Søren Hansen wrote:
> > The server can't trust the client as it is now anyway. The client can do
> > whatever it wants already. There is no security impact as I see it.
> 
> First, if the server refuses to map uids into what it considers system 
> (say, those less than 100... or better, 1000) then the daemons that may be
> using those uids/gids on the server (or other hosts even) will be
> protected from a simple mapping attack. Any attempt to do so will be detected
> by the server, blocked, and reported.
> 
> Second, if the various organizations are mapped, then only maps (and 
> uids/gids) authorized by those maps can be used. Any hanky panky on the
> client host will ONLY involve those accounts/uids already on the client. They
> will NOT be able to map to accounts/uids that are assigned to the other
> organization. Again, attempts to access improper accounts will be detected
> by the server, blocked,  and reported.

I agree with Søren on this.  If the client is compromised such that the
attacker can manipulate the maps (i.e. root) then there is no reason why
the attacker can't just "su" to any UID it wants (regardless of mapping)
and NFS is none-the-wiser.

If the client is trusted to mount NFS, then it is also trusted enough not
to use the wrong UID.  There is no "more" or "less" safe in this regard.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


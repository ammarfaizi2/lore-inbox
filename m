Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbTENBuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTENBuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:50:18 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:10394 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261670AbTENBuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:50:11 -0400
Date: Tue, 13 May 2003 22:02:56 -0400
To: "Douglas E. Engert" <deengert@anl.gov>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030514020240.GA18680@delft.aura.cs.cmu.edu>
Mail-Followup-To: "Douglas E. Engert" <deengert@anl.gov>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
References: <8812.1052841957@warthog.warthog> <Pine.LNX.4.44.0305130929340.1678-100000@home.transmeta.com> <20030513172029.GB25295@delft.aura.cs.cmu.edu> <3EC13E94.C9771D1F@anl.gov> <20030513203344.GC1005@delft.aura.cs.cmu.edu> <3EC16316.AE33A6C0@anl.gov> <20030513214053.GA8745@delft.aura.cs.cmu.edu> <3EC16E3D.B3EB7410@anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC16E3D.B3EB7410@anl.gov>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:14:21PM -0500, Douglas E. Engert wrote:
> Jan Harkes wrote:
> > PAG != tokens.
> > 
> > PAG is a simple unique session identifier. AFS, Coda and DCE/DFS happen
> > associate credentials with a session.
> > 
> > But there is no reason why multiple PAG's can't map to the same set of
> > credentials. 
> 
> True. But traditionally with AFS or DCE at lest they have not. Each had its
> own set of credentials, and the PAG was only defined to allow the credentials
> to be shared. 

Actually, the PAG was defined to temporarily disable membership in one
or more groups. Every process would normally run in PAG 0, and the
credentials were shared based on the uid. When a user wanted to
'restrict' rights he would initiate a new PAG which provided a more
limited environment.

This is my interpretation of the AFS paper that documents the original
security policies of AFS as it was initially deployed on November 11,
1986.

    Integrating Security in a Large Distributed System  (# 12)
    Satyanarayanan, M.
    ACM Transactions on Computer Systems
    Aug. 1989, Vol. 7, No. 3, pp. 247-280 

http://www-2.cs.cmu.edu/afs/cs/project/coda-www/ResearchWebPages/docdir/sec89.pdf

    The process authentication group is described on pages 22-23 in the
    pdf, 268-269 in the original ACM publication.

Jan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267917AbUHEXQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267917AbUHEXQZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUHEXP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:15:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21167 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267885AbUHEXOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:14:51 -0400
Date: Thu, 5 Aug 2004 19:33:19 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Mr. Berkley Shands" <berkley@cse.wustl.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Message-ID: <20040805223319.GA18155@logos.cnet>
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com> <4112917A.3080003@cse.wustl.edu> <20040805204615.GJ17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20040805204615.GJ17188@holomorphy.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 05, 2004 at 01:46:15PM -0700, William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> >> By any chance could you do binary search on the bk snapshots between
> >> 2.6.6 and 2.6.7?
> 
> On Thu, Aug 05, 2004 at 02:58:50PM -0500, Mr. Berkley Shands wrote:
> > the problem does not exist using 2.6.6-bk6, but exists on 2.6.6-bk7. 
> > -bk8 and -bk9 faile to build.
> > these are from patches-2.6.6-bk6 off snapshots/old and applied to a 
> > vanilla 2.6.6 kernel.
> 
> This is the closest it appears to be possible to narrow down where the
> regression happened.
> 
> Some form of changelogging to enumerate what the contents of the
> 2.6.6-bk6 -> 2.6.6-bk7 delta are and to reconstruct intermediate points
> between 2.6.6-bk6 and 2.6.6-bk7 is needed.

Indeed its nasty, the problem is there is no tagging in the main BK repository
representing the -bk tree's. It shouldnt be too hard to do something about 
this? I can't think of anything which could help...

> I have already tried to carry out various procedures to accomplish this
> for several other problem reports and/or issues and come have come away
> from the effort highly discouraged (having made zero progress) each time.

A quick look in bk6-bk7 reveals the regression is probably related 
to either the readahead changes or, less likely, the mm/vmscan.c 
changes.

I'm attaching a tarball with "readahead" and "vmscan", Mr. Berkley 
can you try reverting these ones at a time and repeating your tests?

Thanks!

--mP3DRpeJDSE+ciuQ
Content-Type: application/x-bzip2
Content-Disposition: attachment; filename="patches-bk6-bk7.tar.bz2"
Content-Transfer-Encoding: base64

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

--mP3DRpeJDSE+ciuQ--

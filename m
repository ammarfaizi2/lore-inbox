Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWC1VnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWC1VnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWC1VnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:43:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:7562 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932245AbWC1VnB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:43:01 -0500
Date: Wed, 29 Mar 2006 07:42:14 +1000
From: Nathan Scott <nathans@sgi.com>
To: Peter Palfrader <peter@palfrader.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16: Oops - null ptr in blk_recount_segments?
Message-ID: <20060329074214.D871924@wobbly.melbourne.sgi.com>
References: <20060327022814.GV25288@asteria.noreply.org> <20060327043601.GE27189130@melbourne.sgi.com> <20060327045823.GW25288@asteria.noreply.org> <20060327061021.GT1173973@melbourne.sgi.com> <Pine.LNX.4.61.0603281621210.27529@yvahk01.tjqt.qr> <20060328213845.GO25288@asteria.noreply.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060328213845.GO25288@asteria.noreply.org>; from peter@palfrader.org on Tue, Mar 28, 2006 at 11:38:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 11:38:46PM +0200, Peter Palfrader wrote:
> Jan Engelhardt schrieb am Dienstag, dem 28. März 2006:
> 
> > >These diffs:
> > >
> > >2006-01-18
> > >[XFS] Fix a race in xfs_submit_ioend() where we can ...
> > >2006-01-11
> > >[XFS] fix writeback control handling fix a reversed ...
> > >[XFS] cluster rewrites We can cluster mapped pages ...
> > >[...]
> > 
> > I bet on the 3rd...
> 
> Some of the patches don't unapply cleanly anymore.  I'll see what I can
> do despite that.

You'll be better off trying the bio_clone fix discussed in the
other (ext3-bio_clone-panic) thread than go down this route
(there is a fix in 2.6.16.1 apparently - start there).  Certainly
try that before attempting to revert these changes anyway.

cheers.

-- 
Nathan

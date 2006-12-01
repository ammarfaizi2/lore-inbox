Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161431AbWLAVIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161431AbWLAVIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWLAVIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:08:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:28828 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161431AbWLAVIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:08:52 -0500
Date: Fri, 1 Dec 2006 21:08:49 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Cluster-devel] Re: [GFS2] Change argument of gfs2_dinode_out [17/70]
Message-ID: <20061201210849.GF3078@ftp.linux.org.uk>
References: <1164888933.3752.338.camel@quoit.chygwyn.com> <1165000744.1194.89.camel@xenon.msp.redhat.com> <20061201192555.GD3078@ftp.linux.org.uk> <1165006331.1194.96.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165006331.1194.96.camel@xenon.msp.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 02:52:11PM -0600, Russell Cattelan wrote:
> code clean up are not without risk and with no regression test suite to
> verify
> that a "cleanup" has not broken something. Cleanups are very much a
> hindrance to stabilization. With no know working points in a code
> history it becomes difficult
> to bisect changes and figure out when bugs were introduced
> Especially when cleanups are mixed in with bug fixes.
> 
> Pretty code does not equal correct code.

No, but convoluted and unreadable code ends up being crappier due
to lack of review.  And that's aside of the memory footprint,
likeliness of bugs introduced by code modifications (having in-core
and on-disk data structures with different contents and the same C
type => trouble that won't be caught by compiler), etc.

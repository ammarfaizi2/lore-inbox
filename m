Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVGASEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVGASEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 14:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbVGASEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 14:04:21 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:15031 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261503AbVGASEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 14:04:16 -0400
Date: Fri, 1 Jul 2005 20:04:15 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
Message-ID: <20050701180415.GA7755@janus>
References: <20050630222828.GA32357@janus> <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu> <20050701092444.GA4317@janus> <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu> <20050701120028.GB5218@janus> <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu> <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 07:04:50PM +0200, Miklos Szeredi wrote:

> I'm not saying this is a problem, but also I don't see any
> overwhelming reason to not allow user mounts over non-leaf
> directories.

All things considered I'd still prefer forbidding FUSE mounts on non-leaf
dirs. For name space sanity. And it may be easier to get the whole thing
accepted:

-	One could argue that the existing name space is extended rather than
	changed [for a subset of processes], what Al Viro seems to reject.
-	The processes which cannot be ptraced/sent a signal by the mount
	owner are not "forced" to traverse the FUSE mount for the sake of
	name space invariancy, with all associated security problems: they
	can see everything up to the leaf node of all the usual mounts.

But put otherwise: is there a compelling reason to permit FUSE mounts on
non-leaf nodes?

Can FUSE mount on a file like NFS?

What is your opinion about replacing the ptrace check by a signal check
(later on, no hurry)?

-- 
Frank

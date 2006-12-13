Return-Path: <linux-kernel-owner+w=401wt.eu-S964951AbWLMGf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWLMGf7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 01:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWLMGf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 01:35:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35945 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964951AbWLMGf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 01:35:58 -0500
X-Greylist: delayed 636 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 01:35:58 EST
Date: Wed, 13 Dec 2006 17:25:02 +1100
From: David Chinner <dgc@sgi.com>
To: Shinichiro HIDA <shinichiro@stained-g.net>
Cc: David Chinner <dgc@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com, xfs-masters@oss.sgi.com, Keith Owens <kaos@sgi.com>
Subject: Re: 2.6.18.3 also 2.6.19 XFS xfs_force_shutdown (was: XFS internal error [...])
Message-ID: <20061213062502.GT44411608@melbourne.sgi.com>
References: <9a8748490611280749k5c97d21bx2e499d2209d27dfe@mail.gmail.com> <20061129013214.GH44411608@melbourne.sgi.com> <9a8748490611290117oc0ba880v1a6407bc4f41088f@mail.gmail.com> <20061130020734.GB37654165@melbourne.sgi.com> <87bqm89y6g.wl%shinichiro@stained-g.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bqm89y6g.wl%shinichiro@stained-g.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 02:12:23PM +0900, Shinichiro HIDA wrote:
> Hi,
> 
> I met same problem on my 2 machines, 2.6.19 (Debian unstable) also
> 2.6.18.3 (Debian stable),

The trace:

> ;; [1] lune: debian unstable with 2.6.19
> Dec 12 21:31:25 lune kernel:  [<c0297b70>] xfs_da_do_buf+0x340/0xa10
> Dec 12 21:31:25 lune kernel:  [<c02982ec>] xfs_da_read_buf+0x3c/0x40
> Dec 12 21:31:25 lune kernel:  [<c02a3e28>] xfs_dir2_leafn_lookup_int+0x2e8/0x540
> Dec 12 21:31:25 lune kernel:  [<c02a3e28>] xfs_dir2_leafn_lookup_int+0x2e8/0x540
> Dec 12 21:31:25 lune kernel:  [<c029e3bd>] xfs_dir2_data_log_unused+0x6d/0x90
> Dec 12 21:31:25 lune kernel:  [<c02982ec>] xfs_da_read_buf+0x3c/0x40
....

Should have been preceeded with some other output explaining the
reason for the shutdown. Did these machines run 2.6.17.x where x<= 6?
i.e. is this problem:

http://oss.sgi.com/projects/xfs/faq.html#dir2

The one you are tripping over?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

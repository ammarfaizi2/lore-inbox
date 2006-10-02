Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbWJBGV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWJBGV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWJBGV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:21:28 -0400
Received: from 1wt.eu ([62.212.114.60]:2820 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S932639AbWJBGV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:21:27 -0400
Date: Mon, 2 Oct 2006 07:49:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: David Lang <dlang@digitalinsight.com>
Cc: Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>, linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
Message-ID: <20061002054918.GA8388@1wt.eu>
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu> <Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 10:11:49PM -0700, David Lang wrote:
> On Mon, 2 Oct 2006, Willy Tarreau wrote:
> 
> >A lot of improvement can be made in tar to compress better archive with
> >large number of small files such as the kernel. You just have to see the
> >difference in archive size depending on the base directory name. If you
> >come up with something really interesting which does not alter the output
> >format nor the compression time, it might get a place in the git-tar-tree
> >command. But IMHO, it would me more interesting to further reduce patches
> >size than tarballs size, since patches might be downloaded far more often.
> 
> I just had what's probably a silly thought.
> 
> as an alturnative to useing tar, what about useing a git pack?

Nice idea, but I tried on 2.4 : 43 MB for git-pack vs 38 for tar.gz and
31 for tar.bz2. However, it is blazingly fast. 4 seconds vs 30 for tar.gz
(hot cache).

When speed is important, it's a clear winner. When size matters, it's not
the best solution.

Regards,
Willy


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270846AbTHFSwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270858AbTHFSwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:52:20 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53255
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270846AbTHFSwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:52:17 -0400
Date: Wed, 6 Aug 2003 11:52:14 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030806185214.GD21290@matchmail.com>
Mail-Followup-To: Jan Niehusmann <jan@gondor.com>,
	linux-kernel@vger.kernel.org
References: <20030806150335.GA5430@gondor.com> <20030806110634.G7752@schatzie.adilger.int> <20030806183822.GA6744@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806183822.GA6744@gondor.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 08:38:22PM +0200, Jan Niehusmann wrote:
> Can you explain how a r/o mounted file system can cause problems?
> Perhaps there is still some connection to my problem.

No it shouldn't cause problems, only that you should umount the filesystem
before you mount it read/write because the fsck might have changed
something, and the kernel will have the old information still in memory, and
might cause MORE corruption, than before.

So, just umount after fsck and you should be set (at least for that part)...

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267696AbUH1T5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267696AbUH1T5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUH1T5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:57:14 -0400
Received: from holomorphy.com ([207.189.100.168]:57512 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266474AbUH1T5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:57:05 -0400
Date: Sat, 28 Aug 2004 12:56:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: Re: 2.6.9-rc1 bk-current v2 mount "stale file handle" problems
Message-ID: <20040828195659.GQ5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	nfs@lists.sourceforge.net
References: <4130E094.1010309@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4130E094.1010309@backtobasicsmgmt.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 12:44:20PM -0700, Kevin P. Fleming wrote:
> I just upgraded two of my boxes here to 2.6.9-rc1 pulled from BitKeeper 
> a few hours ago. One of them is my NFS server, using the kernel NFS 
> daemon and serving XFS filesystems. The other is an NFS root client, 
> using the kernel's autoconfiguration and NFS root mounting (using all 
> default mount options).
> After booting the NFS client, I had very strange behavior when creating 
> symlinks on the NFS root if the link target path began with '.'. Just 
> this sequence:
> # mkdir foo
> # cd foo
> # ln -sf . test1
> # ln -sf . test2
> ...
> Would result in a successfully created link but an error message from ln 
> reporting "stale NFS file handle".
> Switching the NFS root client's mount to v3 from v2 seems to have 
> avoided the problem.

I'm getting similar trouble, though I've not noticed the nfs version
workaround.

-- wli

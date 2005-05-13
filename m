Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVEMUrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVEMUrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVEMUdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:33:40 -0400
Received: from mail.uni-ulm.de ([134.60.1.1]:15611 "EHLO mail.uni-ulm.de")
	by vger.kernel.org with ESMTP id S262526AbVEMURO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:17:14 -0400
Date: Fri, 13 May 2005 22:18:15 +0200
From: Markus Klotzbuecher <mk@creamnet.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Message-ID: <20050513201814.GA8208@mary>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	linux-kernel@vger.kernel.org
References: <20050509183135.GB27743@mary> <20050512121842.GA20388@wohnheim.fh-wedel.de> <20050512164413.GA14099@mary> <2F200E69-465D-46ED-9D3A-5ED5C9FEAC9A@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2F200E69-465D-46ED-9D3A-5ED5C9FEAC9A@mac.com>
User-Agent: Mutt/1.5.8i
X-DCC-sgs_public_dcc_server-Metrics: gemini 1199; Body=3 Fuz1=3 Fuz2=3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 11:18:36PM -0400, Kyle Moffett wrote:

> 2) When forced to copy data, the copy should be done in the context of
> whatever process is doing the "write" operation, and be interruptible,
> etc.  The end result is that if you union an nfs mount over another one,
> it will just seem like a write to a big file takes a _really_ long time
> to complete.

This is what happens with mini_fo, provided your kernel is preemptive.

> 3) ext2/3 should get an extra flag for files and directories that
> indicates nonresidence.  This would be used by the VFS union layer to
[...]

I like the idea of copying modified data on a per block basis. This
really would avoid unnecessary long copy operations and potentially
save a lot of storage. But I think a unifying layer should not rely on
specialities such as sparse files or flags provided by the lower layer
file systems.

Markus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUEQTkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUEQTkB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUEQTkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:40:01 -0400
Received: from ipx10069.ipxserver.de ([80.190.240.67]:14785 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S262391AbUEQTj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:39:57 -0400
Date: Mon, 17 May 2004 21:39:54 +0200
From: felix-kernel@fefe.de
To: linux-kernel@vger.kernel.org
Subject: [2.6.5, ext3] getdents reports files that stat says aren't there
Message-ID: <20040517193954.GA14835@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I keep getting this effect on my ext3 file system.
Applications like ls call readdir, get long deleted files, then stat
them, and get ENOENT.

Most applications can handle this, but some report ugly errors or
warnings.  I wonder: why does getdents report entries of deleted files?
I ran e2fsck on the partition, but it found nothing.  So I guess it's
not a file system error.  I have been seeing this for months now.  It
does not actually hurt a lot, but I think it should be fixed
nonetheless.

Felix

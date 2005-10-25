Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVJYHuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVJYHuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVJYHuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:50:55 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:10605 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932075AbVJYHuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:50:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=AszEJ7Cw0vfePfX6rmgcpUYwVWuUdlp9HUKJ+TuUt5PXc8kiCYY3jnqDQ4nKiYb1MhKQoVPArXeD9ixPfTrx8XNChCZ6zIditLOFyGieoqVWvBCyanHM3RLOl4u7fRv5aiS/JPv2LKPImiO3t8sOyxjTXpyVQL6cHEpBVfbGYRU=
Date: Tue, 25 Oct 2005 12:03:19 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: When did UFS read-write work?
Message-ID: <20051025080319.GA10234@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to copy a small file to a partition mounted as ufstype=44bsd.
It hanged while doing

	open("file", O_WRONLY|O_CREAT|O_LARGEFILE, 0100644)

Second time, there was no hang, but there was no file on UFS partition
too.

Rebooting to OpenBSD:

	~ $ cd linux/		<=== created by Linux
	~/linux $ ls -la
	ls: .: No such file or directory

Does anyone remeber when UFS rw was OK?


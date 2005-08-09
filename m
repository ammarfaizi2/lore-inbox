Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVHIQHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVHIQHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbVHIQHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:07:05 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:55246 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964850AbVHIQHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:07:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=uS0YcT3Ez3DsiWWa5D3r8RFNPTxpyalD5QjABsz+x4XDVhFFikvHlHjBCCMPFI85hGF/FG1Z8RCuQyKS7KXPh2YurTp7+viflksZjRsjq5DODWnw6tXhVWfuCRUREJhaYFZ0jMEMYU67mGL6CK0Adz8s7fWi1NZRDtD6UheDMrQ=
Date: Wed, 10 Aug 2005 00:06:41 +0800
From: lepton <ytht.net@gmail.com>
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org
Subject: Why don't register a d_delete function for externfs_dentry_ops in 2.4 kernel?
Message-ID: <20050809160641.GA4946@gsy2.lepton.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
	I read about code of linux-2.4.31/arch/um/fs/hostfs/externfs.c

	I found you have defined a function named exterfs_d_delete, but
	you don't register this function in externfs_dentry_ops.

	This behavior is diffrent from the hostfs code in 2.6 kernel

	It will lead to some strange problem like this:

	on guest UML box:  ls -l /tmp/nonexist  ( the result is "file not
	found", it is correct)

	IN the directory of host os: touch ..../tmp/nonexist

	on guest UML box again: ls -l /tmp/nonexist ( the result keeps "file
	not found",  a incorrect negative dcache hit)

	I don't kown why 2.4 kernel have not fixed it.

	What do you think about it?

	Thanks

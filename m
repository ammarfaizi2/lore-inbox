Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWIMBLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWIMBLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWIMBLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:11:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50816 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030470AbWIMBLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:11:02 -0400
Date: Wed, 13 Sep 2006 02:11:00 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, nacc@us.ibm.com
Subject: Re: [PATCH 1/1] VFS: fixes a bug in sys_linkat()
Message-ID: <20060913011100.GC29920@ftp.linux.org.uk>
References: <200609130057.k8D0vcqJ028474@ram.us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609130057.k8D0vcqJ028474@ram.us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 05:57:38PM -0700, Ram Pai wrote:
> Hardlink using sys_linkat() returns EXDEV when the source and the destination
> point to the same filesystem, residing under different mounts.

... and that is absolutely deliberate.  Ability to restrict links to
a subtree is a deliberate feature.

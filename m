Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266082AbTIKEzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266083AbTIKEzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:55:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20105 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266082AbTIKEzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:55:11 -0400
Date: Thu, 11 Sep 2003 05:55:07 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Local DoS on single_open?
Message-ID: <20030911045507.GQ454@parcelfarce.linux.theplanet.co.uk>
References: <3741.1063255333@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3741.1063255333@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 02:42:13PM +1000, Keith Owens wrote:
> single_open() requires the kernel to kmalloc a buffer which lives until
> the userspace caller closes the file.  What prevents a malicious user
> opening the same /proc entry multiple times, allocating lots of kmalloc
> space and causing a local DoS?

Size of that buffer is limited.  IOW, it's not different from opening
e.g. a shitload of pipes or sockets.

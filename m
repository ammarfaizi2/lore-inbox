Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268331AbUI2MSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268331AbUI2MSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUI2MSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:18:51 -0400
Received: from mail.zmailer.org ([62.78.96.67]:6562 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S268331AbUI2MSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:18:47 -0400
Date: Wed, 29 Sep 2004 15:18:46 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compressed filesystems:  Better compression?
Message-ID: <20040929121846.GT19844@mea-ext.zmailer.org>
References: <415A302E.5090402@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415A302E.5090402@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 11:46:54PM -0400, John Richard Moser wrote:
> I wonder what compression Squashfs, cramfs, and zisofs use.  I think
> cramfs uses zlib compression; I don't know of any other compression in
> the kernel tree, so I assume zisofs uses the same, as does squashfs.  Am
> I mistaken?

Compression algorithms are a bit tough to be used in a random access
smallish blocks environments.  In long streams where you can use megabytes
worth of buffer spaces there is no problem is achieving good performance.
But do try to do that in an environment where your maximum block size
is, say: 4 kB, and you have to start afresh at every block boundary.

Whatever algorithms you use, there will always be data sequences that
are of maximum entropy, and won't compress.  Rather they will be
presented in streams as is with a few bytes long wrappers around
them.

/Matti Aarnio

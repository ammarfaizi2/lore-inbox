Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWCSAqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWCSAqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 19:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWCSAqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 19:46:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:25010 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751151AbWCSAqk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 19:46:40 -0500
Date: Sun, 19 Mar 2006 00:46:39 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, becker@scyld.com
Subject: Re: [PATCH] Fix a potential NULL pointer deref in znet
Message-ID: <20060319004639.GY27946@ftp.linux.org.uk>
References: <200603190112.31828.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603190112.31828.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 01:12:31AM +0100, Jesper Juhl wrote:
> 
> The coverity checker spotted that we dereference a pointer before we check it
> for NULL in drivers/net/znet.c::znet_interrupt().
> This fixes the issue.

The hell it does.  Either interrupt really isn't shared, in which case
this check should be simply removed, or it can be shared, in which case
the code is still buggered.

Please, stop pulling Bunk - _think_ before submitting "make <program> STFU"
patches.

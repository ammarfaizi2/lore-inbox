Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWIVXt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWIVXt3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWIVXt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:49:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3806 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964939AbWIVXt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:49:29 -0400
Date: Sat, 23 Sep 2006 00:49:27 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Scott Baker <smbaker@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fault when using iget() on XFS file system (2.6.9)
Message-ID: <20060922234927.GU29920@ftp.linux.org.uk>
References: <35a82d00609221642u2e4a5026w434584ff77b7b9bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a82d00609221642u2e4a5026w434584ff77b7b9bb@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 04:42:41PM -0700, Scott Baker wrote:
> I'm working on a kernel module that needs to perform an iget() on an
> inode that lies in the XFS file system.

Explain why you think you need iget().  It's almost certainly a Bad Idea(tm) -
code outside of filesystem has no business calling it.

Without more context there's no way anyone can help.  What does that
module attempt to do?

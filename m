Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269012AbUIMW0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269012AbUIMW0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269019AbUIMW0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:26:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52687 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269015AbUIMW0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:26:22 -0400
Date: Mon, 13 Sep 2004 23:26:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: David Dabbs <david@dabbs.net>
Cc: "'ReiserFS List'" <reiserfs-list@namesys.com>,
       linux-kernel@vger.kernel.org, "'Alex Zarochentsev'" <zam@namesys.com>
Subject: Re: [PATCH] use S_ISDIR() in link_path_walk() to decide whether the last path component is a directory
Message-ID: <20040913222618.GE23987@parcelfarce.linux.theplanet.co.uk>
References: <20040913213429.6813115CA8@mail03.powweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913213429.6813115CA8@mail03.powweb.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 04:34:15PM -0500, David Dabbs wrote:
> I'm working on something similar, but with alternate pathname resolution
> when the path begins with exactly two slashes. Only pseudocode here because
> I do not have access to my box:
> 
>     if (*name == '/') {
>        if (*(name+1)=='/' && *(name+2)==':') {
>           name+=3;

	Pathname resolution is a hell of a fundamental thing and kludges
like that are too ugly to be acceptable.  If you can't make that clean
and have to resort to stuffing "special cases" (read: barfbag of ioctl
magnitude) into the areas that might be unspecified by POSIX, don't do it
at all.

	I don't like the amount of handwaving from Hans, but *that* is far
worse.  Vetoed.

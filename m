Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVIUBfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVIUBfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVIUBfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:35:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7101 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750866AbVIUBfF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:35:05 -0400
Date: Wed, 21 Sep 2005 02:35:06 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Latchesar Ionkov <lucho@ionkov.net>
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] v9fs-get-sb-cleanup.patch
Message-ID: <20050921013506.GS7992@ftp.linux.org.uk>
References: <20050921012526.GF2008@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921012526.GF2008@ionkov.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 09:25:26PM -0400, Latchesar Ionkov wrote:
> Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
> 
> if error occurs while in v9fs_get_sb, some objects are freed twice -- once
> in v9fs_get_sb, the second time when v9fs_kill_super is (indirectly
> called).
 
Huh?  ->kill_sb() is *NOT* called when ->get_sb() fails.

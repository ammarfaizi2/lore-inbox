Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWBLVQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWBLVQv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWBLVQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:16:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36587 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750883AbWBLVQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:16:51 -0500
Date: Sun, 12 Feb 2006 21:16:46 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linda Walsh <lkml@tlinx.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use one constant to control MAX SYMLINKS in a name
Message-ID: <20060212211646.GW27946@ftp.linux.org.uk>
References: <43ED5A7B.7040908@tlinx.org> <Pine.LNX.4.61.0602121126410.25363@yvahk01.tjqt.qr> <43EF9E96.109@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EF9E96.109@tlinx.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 12:46:14PM -0800, Linda Walsh wrote:
>    I'd suggest changing the number in line 14 in namei.h to 40
> as well, thus using the same limit in both cases and clearing up
> such confusion.
> 
> The following patch (against 2.6.15.4) seems to make this change and fixes
> up the comments:

It also creates a trivially exploitable stack overflow.

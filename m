Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbULINx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbULINx1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 08:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbULINx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 08:53:27 -0500
Received: from unthought.net ([212.97.129.88]:55749 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261308AbULINxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 08:53:23 -0500
Date: Thu, 9 Dec 2004 14:53:23 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20041209135322.GK347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
	kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209125918.GO9994@fi.muni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 01:59:18PM +0100, Jan Kasprzak wrote:
> 	Hi all,
> 
> I have seen the strange problem on our NFS server: yesterday I have
> found an empty file owned by UID 0/GID 0 and st_mode == 0 in my home
> directory (ls -l said "?--------- 1 root root 0 <date> <filename>").
> The <filename> was correct name of a temporary file used by one of my
> cron jobs (and the cron job was failing because it could not rewrite the file).
> It was not possible to write to this file, so I have renamed it
> as "badfile" for further investigation (using mv(1) on the NFS server itself).

Known problem

http://lkml.org/lkml/2004/11/23/283

Seems there is no solution yet

http://lkml.org/lkml/2004/11/30/145

...
> 
> Maybe some data is flushed in an incorrect order?

Maybe  :)

-- 

 / jakob


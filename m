Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVACVbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVACVbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVACV2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:28:47 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:16374 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261867AbVACVYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:24:12 -0500
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
From: Nicholas Miell <nmiell@comcast.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41D9B1C4.5050507@zytor.com>
References: <41D9B1C4.5050507@zytor.com>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 13:24:07 -0800
Message-Id: <1104787447.3604.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 12:57 -0800, H. Peter Anvin wrote:
> This patch adds a set of ioctls to get and set the FAT filesystem native 
> attribute bits, including the unused bits (6 and 7.)
> 

Instead of adding another ioctl, wouldn't an xattr be more appropriate?
For instance, system.fatattrs containing a text representation of the
attribute bits.

i.e. 
	a = archive
	d = directory
	h = hidden
	r = read only
	s = system
	v = volume
	6 = unused bit 6
	7 = unused bit 7

and

bash-3.00$ getfattr -n system.fatattrs dosfile.txt
# file: dosfile.txt
system.fatattrs="ar"

bash-3.00$
-- 
Nicholas Miell <nmiell@comcast.net>


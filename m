Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWEMP3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWEMP3s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWEMP3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:29:48 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:10981 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751284AbWEMP3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:29:47 -0400
Message-ID: <4465FB5C.6070808@steeleye.com>
Date: Sat, 13 May 2006 11:29:32 -0400
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Neil Brown <neilb@suse.de>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 008 of 8] md/bitmap: Change md/bitmap file handling to
 use bmap to file blocks.
References: <20060512160121.7872.patches@notabene>	<1060512060809.8099@suse.de>	<20060512104750.0f5cb10a.akpm@osdl.org>	<17509.22160.118149.49714@cse.unsw.edu.au> <20060512235934.4f609019.akpm@osdl.org>
In-Reply-To: <20060512235934.4f609019.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> The loss of pagecache coherency seems sad.  I assume there's never a
> requirement for userspace to read this file.

Actually, there is. mdadm reads the bitmap file, so that would be 
broken. Also, it's just useful for a user to be able to read the bitmap 
(od -x, or similar) to figure out approximately how much more he's got 
to resync to get an array in-sync. Other than reading the bitmap file, I 
don't know of any way to determine that.

--
Paul


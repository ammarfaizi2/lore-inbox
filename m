Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWFSRUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWFSRUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWFSRUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:20:00 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:44931 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964813AbWFSRT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:19:59 -0400
Date: Mon, 19 Jun 2006 19:19:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Theodore Tso <tytso@thunk.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 2/8] inode-diet: Move i_pipe into a union
In-Reply-To: <20060619153108.720582000@candygram.thunk.org>
Message-ID: <Pine.LNX.4.61.0606191918310.23792@yvahk01.tjqt.qr>
References: <20060619152003.830437000@candygram.thunk.org>
 <20060619153108.720582000@candygram.thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Move the i_pipe pointer into a union that will be shared with i_bdev
>and i_cdev.

>+	union {
>+		struct pipe_inode_info	*i_pipe;
>+	};

Since in the next patch you did

-       if (inode->i_bdev)
+       if (S_ISBLK(inode->i_mode) && inode->i_bdev)

I am just asking, for clarity, if there were any similar lines for 
pipes that should now read S_IFIFO(inode->i_mode) too, like for bdevs.


Jan Engelhardt
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272511AbTHEPyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272514AbTHEPyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:54:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:22716 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272511AbTHEPyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:54:35 -0400
Date: Tue, 5 Aug 2003 08:55:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries.Brouwer@cwi.nl
Cc: aebr@win.tue.nl, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: i_blksize
Message-Id: <20030805085557.2f150beb.akpm@osdl.org>
In-Reply-To: <UTC200308050920.h759K2n21546.aeb@smtp.cwi.nl>
References: <UTC200308050920.h759K2n21546.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> Hmm. Let me first read stat.c.

hmm indeed.  Looks like I got myself confused:

fs/ext2/ialloc.c:       inode->i_blksize = PAGE_SIZE;   /* This is the optimal IO size (for stat), not the fs block size */



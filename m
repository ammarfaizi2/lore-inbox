Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVAVWVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVAVWVw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 17:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVAVWVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 17:21:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18922 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262759AbVAVWVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 17:21:51 -0500
Message-ID: <41F2D1E7.30609@pobox.com>
Date: Sat, 22 Jan 2005 17:21:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stone_wang@sohu.com
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch to 2.6.10-rc2] ext3_find_goal
References: <31531613.1106425001426.JavaMail.postfix@mx20.mail.sohu.com>
In-Reply-To: <31531613.1106425001426.JavaMail.postfix@mx20.mail.sohu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stone_wang@sohu.com wrote:
> 
> We found strange blocks layout in our mail server, after careful study,
> we got the reason and tried to fix it.
> 
> When loading an inode from buffer/disk(ext2/3_read_inode),then allocating the second block(block==1) of the corresponding file: i_next_alloc_block and i_next_alloc_goal are both zero,and in fact are not valid,
> but they(i_next_alloc_block/goal) take effect in the former codes. This causes non-contiguous file.
> 
> Below patch add a check,and fixes this.

Good catch!



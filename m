Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbTJBSZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTJBSZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:25:11 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15631 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263411AbTJBSZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:25:07 -0400
Date: Thu, 2 Oct 2003 20:24:57 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-hfsplus-devel@lists.sourceforge.net, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] new HFS(+) driver
In-Reply-To: <20031002180645.GG7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0310022019090.8124-100000@serv>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
 <20031002180645.GG7665@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> What the devil are you doing with get_gendisk() in there?  Neither 2.4
> nor 2.6 should be messing with it.

In 2.6 it's only a debugging check and will be removed. In 2.4 it's 
currently needed to get the correct size. The backup volume sector is in 
the second last (512 byte) sector, but bd_inode->i_size is truncated to 
BLOCK_SIZE.

bye, Roman



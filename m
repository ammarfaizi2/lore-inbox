Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUDJWzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 18:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUDJWzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 18:55:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21144 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262154AbUDJWzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 18:55:16 -0400
Date: Sat, 10 Apr 2004 23:55:14 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andries Brouwer <aebr@win.tue.nl>, fledely <fledely@bgumail.bgu.ac.il>,
       linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Accessing odd last partition sector (was: [Linux-NTFS-Dev] mkntfs dirty volume marking)
Message-ID: <20040410225514.GX31500@parcelfarce.linux.theplanet.co.uk>
References: <20040410211301.GW31500@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.21.0404102352520.840-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0404102352520.840-100000@mlf.linux.rulez.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2004 at 12:23:47AM +0200, Szakacsits Szabolcs wrote:
 
> Just one question, in the most common cases the block size ends up between
> 512 and 4096 bytes. Depending on how this block size used, it can have a
> significant impact on performance (e.g. 512 vs 4096). Is this true or is
> it used to be performance independent?

Resulting requests are immediately merged anyway.  Yes, we get more bio
sitting on top of the merged request; however, it's heavily IO-dominated
and I would be surprised if you really saw any noticable overhead in that
situation.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267802AbUG3ThR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267802AbUG3ThR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUG3ThQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:37:16 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:43690 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S267811AbUG3Tgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:36:52 -0400
Date: Fri, 30 Jul 2004 14:36:51 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: linux-kernel@vger.kernel.org
Subject: ide-cd problems
Message-ID: <20040730193651.GA25616@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to bump this topic a bit, since it's been a while..
There are still some issues with ide-cd's SG_IO, listed from
most important as percieved by me to least:

 * Read-only access grants you the ability to write/blank media in the drive
 * (with above) You can open the device only in read-only mode.
 * You can't open the device unless there is media in the drive
 * Still seems to be no way to specify scatter gather/dma buffers yourself,
   though I'm not entirely sure that matters anyway.

The read-only granting write/blank seems like a pretty serious security issue
to me.  Not being able to open the device without media is merely extremely
annoying (and I suspect fixing it would break a lot of programs).

-- 
Zinx Verituse                                    http://zinx.xmms.org/

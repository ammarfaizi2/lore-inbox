Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbUAEUyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUAEUyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:54:11 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:33997 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S264494AbUAEUyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:54:08 -0500
To: linux-kernel@vger.kernel.org
Subject: RAID1 resync speed in 2.6.0
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 05 Jan 2004 21:54:05 +0100
Message-ID: <yw1xptdy15hu.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just set up a largish (~100 GB) RAID1 array under Linux 2.6.0.  Now,
/proc/mdstat is happily telling me that the resync will be completed
in 3700 minutes.  This seems terribly slow to me.  At first, it
wouldn't work at all, complaining about "bio too big", so I changed
RESYNC_BLOCK_SIZE to 32k.

Is there a way to mark the superblocks as up to date manually?  I
don't really care what a read will return for parts of the array that
I haven't written to yet.

-- 
Måns Rullgård
mru@kth.se

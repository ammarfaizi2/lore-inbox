Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264811AbUE0PpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264811AbUE0PpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbUE0PpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:45:13 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:48652 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S264811AbUE0PpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:45:10 -0400
Subject: Process hangs on blk_congestion_wait copying large file to cifs
	filesystem
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Graycell
Date: Thu, 27 May 2004 16:45:06 +0100
Message-Id: <1085672706.4350.9.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2004 15:41:19.0648 (UTC) FILETIME=[0E299A00:01C44401]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to copy a large file (200Mb or bigger) from an ext3
filesystem to a windows share mounted using CIFS and the cp process
hangs, sometimes for a long time (several minutes).
Calling ps, I can see that it's blocking on blk_congestion_wait.

Trying to edit a file on the same ext3 filesystem using vi blocks on the
same function. However, during that that same time that vi and cp were
blocked, I was able to do a "find /usr/share/doc" and it completed
normally, in a few seconds.

Eventually the copy succeeds but it takes a long time (20 minutes to
copy 200Mb) and the computer is unusable during most of that time.

This is copying from my laptop (IDE disk), the network card is a RTL8139
using 8139cp drivers.

Is someone seeing a similiar problem? What extra info is needed to debug
it?

Thanks
-- 
Nuno Ferreira


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268721AbUHLUH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268721AbUHLUH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268701AbUHLUH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:07:26 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:44809 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S268741AbUHLUGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:06:47 -0400
Subject: Re: Process hangs copying large file to cifs
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: "Steve French (IBM LTC)" <smfltc@us.ibm.com>
Cc: linux-cifs-client@lists.samba.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <411C60EA.EA01F2A2@us.ibm.com>
References: <1088459930.5666.8.camel@stevef95.austin.ibm.com>
	 <1088507544.2418.1.camel@taz.graycell.biz>
	 <1092328302.4172.42.camel@taz.graycell.biz>  <411C60EA.EA01F2A2@us.ibm.com>
Content-Type: text/plain
Organization: Graycell
Date: Thu, 12 Aug 2004 21:06:45 +0100
Message-Id: <1092341205.4172.49.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Aug 2004 20:06:46.0112 (UTC) FILETIME=[E4E1E600:01C480A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sex, 2004-08-13 at 01:34 -0500, Steve French (IBM LTC) wrote:
> Your log entries indicate that the socket was dead, so the patch you hand applied for hashing of inodes
> appears unrelated.

I just mentioned the previous problem because the behaviour was pretty
much the same as before, long times of no TCP traffic, intermittent
freezes apparently of all the processes trying to do IO to the disk.

> Many (including myself copy) much larger files regularly via CIFS.

It appears (purely speculation, no hard facts to back it up) related to
memory pressure, it doesn't happen with smaller files (my laptop has
512Mb) and it happens less often on the second copy if the file fits on
cache. 

> I don't know
> whether the best approach is to backport the other fixes that could affect this code path to your kernel
> so we can see if this is a current problem in some recovery path or has already been fixed.   There are
> only three to four global changes in the kernel (that hit the fs/cifs directory) since 2.6.6 that would
> have to be dealt with to compile the current 2.6.8 fs/cifs directory on an older 2.6.6 kernel.

I'm running 2.6.7, are the changes contained in 2.6.8-rc(something)? I
cant try them or an -mm kernel if you prefer.

-- 
Nuno Ferreira


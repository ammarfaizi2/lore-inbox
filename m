Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUHMQVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUHMQVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUHMQVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:21:37 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:31238 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S266147AbUHMQV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:21:26 -0400
Subject: Re: Process hangs copying large file to cifs
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: "Steve French (IBM LTC)" <smfltc@us.ibm.com>
Cc: linux-cifs-client@lists.samba.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1092341205.4172.49.camel@taz.graycell.biz>
References: <1088459930.5666.8.camel@stevef95.austin.ibm.com>
	 <1088507544.2418.1.camel@taz.graycell.biz>
	 <1092328302.4172.42.camel@taz.graycell.biz>  <411C60EA.EA01F2A2@us.ibm.com>
	 <1092341205.4172.49.camel@taz.graycell.biz>
Content-Type: text/plain
Organization: Graycell
Date: Fri, 13 Aug 2004 17:21:22 +0100
Message-Id: <1092414083.4247.11.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Aug 2004 16:21:24.0143 (UTC) FILETIME=[9392EBF0:01C48151]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Qui, 2004-08-12 at 21:06 +0100, Nuno Ferreira wrote:
> On Sex, 2004-08-13 at 01:34 -0500, Steve French (IBM LTC) wrote:
> > Your log entries indicate that the socket was dead, so the patch you hand applied for hashing of inodes
> > appears unrelated.
> 
> I just mentioned the previous problem because the behaviour was pretty
> much the same as before, long times of no TCP traffic, intermittent
> freezes apparently of all the processes trying to do IO to the disk.
> 
> > Many (including myself copy) much larger files regularly via CIFS.
> 
> It appears (purely speculation, no hard facts to back it up) related to
> memory pressure, it doesn't happen with smaller files (my laptop has
> 512Mb) and it happens less often on the second copy if the file fits on
> cache. 

I've now reproduced it with 2.6.8-rc4. Just after boot I could not
reproduce it with the previous file, but trying with a larger (350Mb)
file it happened again. Another hint to memory pressure? I will try
again in a few hours with the smaller file to see if it happens...
Just tried, this time it happened with the first (smaller) file.
What info can I try to collect to help you find the problem?
-- 
Nuno Ferreira


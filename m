Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWDKKmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWDKKmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWDKKlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:41:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:59810 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750729AbWDKKli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:41:38 -0400
From: Neil Brown <neilb@suse.de>
To: "Dr.Peer-Joachim Koch" <pkoch@bgc-jena.mpg.de>
Date: Tue, 11 Apr 2006 20:41:10 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17467.34758.885496.639274@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFSD stops working
In-Reply-To: message from Dr.Peer-Joachim Koch on Tuesday April 11
References: <443B8417.8020706@bgc-jena.mpg.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 11, pkoch@bgc-jena.mpg.de wrote:
> Hi,
> 
> we have a big problem with the nfsd.
> 
> Our system is running SuSE SLES 9 SP2 (AMD64)on
> 6 Sun X4100 (1 Opteron 275, 4GB RAM, 1 *QLA2340)
> All machines are connect via SAN to a EMC CX700.
> 
> Software installed SuSE SLES 9 SP2, kernel 2.6.5-7.191-smp
> which is required for the GFS (Adic StorNEXT 2.6.1)
> and also for EMC Powerpath to access the lun's.

Any chance of upgrading to SP3 ??

> 
> After 8 to 80h one (not allways the same)
> of the NFS server is starting to increase
> the load from 0 -> ~7.5.
> The system is not exporting any file system.
> The system can be accessed using ssh.
> Files CAN be seen, created and delete on the machine
> locally.
> The nfsd can't not be stopped and taking all of the
> cpu time.
> The load is rather small.
> Only solution is a hard reboot for the node.
> 
> dmesg shows nothing, neither messages.
> fuser will not work (hanging)
> 
> a) How can I get more information ?

   echo t > /proc/sysrq-trigger
and collect the trace from /var/log/messages.  That will show what
each nfsd thread is doing.

Post that and I'll see if it helps.

NeilBrown

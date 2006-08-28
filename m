Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWH1DrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWH1DrW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 23:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWH1DrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 23:47:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:40861 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932382AbWH1DrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 23:47:21 -0400
From: Neil Brown <neilb@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Date: Mon, 28 Aug 2006 13:47:17 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17650.26437.447617.467168@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [bug?] raid1 integrity checking is broken on 2.6.18-rc4
In-Reply-To: message from Chuck Ebbert on Thursday August 17
References: <200608171605_MC3-1-C870-8190@compuserve.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 17, 76306.1226@compuserve.com wrote:
> 
> I just tried the patch and now it seems to be syncing the drives instead
> of only checking them?  (At the very least the message is misleading.)
> 

Yes, the message is misleading.  I should fix that.

NeilBrown


>  # echo "check" >/sys/block/md0/md/sync_action
>  # dmesg | tail -9
>  md: syncing RAID array md0
>  md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
>  md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for reconstruction.
>  md: using 128k window, over a total of 104256 blocks.
>  md: md0: sync done.
>  RAID1 conf printout:
>   --- wd:2 rd:2
>   disk 0, wo:0, o:1, dev:hda9
>   disk 1, wo:0, o:1, dev:sda5
> 

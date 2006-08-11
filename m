Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWHKAdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWHKAdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWHKAdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:33:39 -0400
Received: from mx1.suse.de ([195.135.220.2]:52682 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932336AbWHKAdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:33:38 -0400
From: Neil Brown <neilb@suse.de>
To: Willy Tarreau <w@1wt.eu>
Date: Fri, 11 Aug 2006 10:33:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17627.53340.43470.60811@cse.unsw.edu.au>
Cc: Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: What's the NFS OOM problem?
In-Reply-To: message from Willy Tarreau on Thursday August 10
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>
	<20060810045711.GI8776@1wt.eu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 10, w@1wt.eu wrote:
> 
> > Can someone help me and give me a brief description on OOM issue?
> 
> I don't know about any OOM issue related to NFS. At most it might happen
> on the client (eg: stating firefox from an NFS root) which might not have
> enough memory for new network buffers, but I don't even know if it's
> possible at all.

We've had reports of OOM problems with NFS at SuSE.
The common factors seem to be lots of memory (6G+) and very large
files. 
Tuning down  /proc/sys/vm/dirty_*ratio seems to avoid the problem,
but I'm not very close to understanding what the real problem is.

NeilBrown

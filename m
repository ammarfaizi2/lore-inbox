Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWAaBKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWAaBKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 20:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWAaBKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 20:10:39 -0500
Received: from mail.suse.de ([195.135.220.2]:59822 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965056AbWAaBKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 20:10:38 -0500
From: Neil Brown <neilb@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 31 Jan 2006 12:10:32 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17374.47368.715991.422607@cse.unsw.edu.au>
Cc: klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: Exporting which partitions to md-configure
In-Reply-To: message from H. Peter Anvin on Monday January 30
References: <43DEB4B8.5040607@zytor.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 30, hpa@zytor.com wrote:
> 
> Any feeling how best to do that?  My current thinking is to export a 
> "flags" entry in addition to the current ones, presumably based on 
> "struct parsed_partitions->parts[].flags" (fs/partitions/check.h), which 
> seems to be what causes md_autodetect_dev() to be called.
> 

I think I would prefer a 'type' attribute in each partition that
records the 'type' from the partition table.  This might be more
generally useful than just for md.
Then your userspace code would have to look for '253' and use just
those partitions.

NeilBrown

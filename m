Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVB1FuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVB1FuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 00:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVB1FuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 00:50:12 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:15322 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261562AbVB1FuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 00:50:04 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Brad Campbell <brad@wasp.net.au>
Date: Mon, 28 Feb 2005 16:49:59 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16930.45319.682534.351648@cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
       RAID Linux <linux-raid@vger.kernel.org>
Subject: Re: Raid-6 hang on write.
In-Reply-To: message from Brad Campbell on Friday February 25
References: <421DE9A9.4090902@wasp.net.au>
	<421F4629.5080309@wasp.net.au>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday February 25, brad@wasp.net.au wrote:
> 
> Turning on debugging in raid6main.c and md.c make it much harder to hit. So I'm assuming something 
> timing related.
> 
> raid6d --> md_check_recovery --> generic_make_request --> make_request --> get_active_stripe

Yes, there is a real problem here.  I see if I can figure out the best
way to remedy it...
However I think you reported this problem against a non "-mm" kernel,
and the path from md_check_recovery to generic_make_requests only
exists in "-mm".

Could you please confirm if there is a problem with
    2.6.11-rc4-bk4->bk10

as reported, and whether it seems to be the same problem.

Thanks,
NeilBrown

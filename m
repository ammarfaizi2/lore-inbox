Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTJ1BIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTJ1BIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:08:39 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:7841 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263795AbTJ1BIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:08:37 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Karl Vogel <karl.vogel@seagha.com>
Date: Tue, 28 Oct 2003 09:34:16 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16285.40296.539477.601100@notabene.cse.unsw.edu.au>
Cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: LVM on md0: raid0_make_request bug: can't convert block acros
	s chunks or bigger than 64k
In-Reply-To: message from Karl Vogel on Saturday October 25
References: <16276.31028.9351.994009@notabene.cse.unsw.edu.au>
	<1067113434.1179.7.camel@kvo.local.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday October 25, karl.vogel@seagha.com wrote:
> 
> 
> I noticed in the 2.6.0-test9 notes the following:
> 
> ---
> Neil Brown:
>   o md -  Use sector rather than block numbers when splitting raid0
>     requests
> ---
> 
> I'm not sure if this is related to the problem I was experiencing?!
> Anyway this doesn't fix the problem I was having. I still get the errors
> with -test9. Above patch to dm-table.c works for me.
> 
> Just thought I'd mention this..
> 
This addresses a different problem: raid0 would not correctly handle
some requests that are not 1K aligned.  XFS does some non-1K-aligned
requests where reading it's journal and caught this bug.
It has nothing to do with LVM or your problem.

NeilBrown


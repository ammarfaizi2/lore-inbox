Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUGWDLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUGWDLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 23:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267513AbUGWDLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 23:11:06 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:65413 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267511AbUGWDLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 23:11:04 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Date: Fri, 23 Jul 2004 13:10:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16640.33197.366067.554037@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raidstart used deprecated START_ARRAY ioctl
In-Reply-To: message from Norberto Bensa on Friday July 9
References: <200407090135.12493.norberto+linux-kernel@bensa.ath.cx>
	<16622.11173.888745.161113@cse.unsw.edu.au>
	<200407090230.24696.norberto+linux-kernel@bensa.ath.cx>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 9, norberto+linux-kernel@bensa.ath.cx wrote:
> 
> >    This is done by set the partition type of all partitions that
> >    contain part of an MD array to "Linux Raid Autodetect" (0xFD).
> >    Then all arrays are found and assembled at boot time.
> >    This requires having all of md (that you need) compiled into the
> >    kernel, not as modules.
> 
> Did I get that right? Can I get rid of raidstart and the array will be 
> "assembled by the kernel"?

Yes.  If all the components of the arrays are in partitions with type
0xFD, and the md driver and raid personalities are compiled into the
kernel (not modules), then the kernel will automatically start the
arrays for you.

NeilBrown

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbTLSDnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 22:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbTLSDnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 22:43:46 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:27546 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265438AbTLSDnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 22:43:45 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Fri, 19 Dec 2003 14:43:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16354.29673.680077.180198@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23: kernel: raid5: multiple 0 requests for sector
In-Reply-To: message from Mike Fedyk on Thursday December 18
References: <20031219032827.GR16034@matchmail.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 18, mfedyk@matchmail.com wrote:
> I have an 300GB ext3, and I'm running bonnie on it while running a read-only
> badblocks on the block device.
> 
> While that's happening I got these:
...
> 
> Is this because the buffer cache and page cache are both asking for the same
> block because they're both reading/writing the same area on disk?

Yes. Actually they're both reading the same block (a 0 request is
read, a 1 is write).

> 
> Dec 17 21:28:26 srv-lnx2600 kernel: raid5: multiple 0 requests for sector 175954880
> Dec 17 21:28:26 srv-lnx2600 kernel: raid5: multiple 0 requests for sector 175954888

NeilBrown

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWIDIZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWIDIZL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 04:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWIDIZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 04:25:10 -0400
Received: from ns1.suse.de ([195.135.220.2]:58811 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750779AbWIDIZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 04:25:08 -0400
From: Andreas Schwab <schwab@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 18/22][RFC] Unionfs: Superblock operations
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	<20060901015851.GS5788@fsl.cs.sunysb.edu>
	<Pine.LNX.4.61.0609040940010.9108@yvahk01.tjqt.qr>
X-Yow: ...I think I'm having an overnight sensation right now!!
Date: Mon, 04 Sep 2006 10:24:56 +0200
In-Reply-To: <Pine.LNX.4.61.0609040940010.9108@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Mon, 4 Sep 2006 09:46:59 +0200 (MEST)")
Message-ID: <jek64k2g4n.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>+/* final actions when unmounting a file system */
>>+static void unionfs_put_super(struct super_block *sb)
>>+{
>>+	int bindex, bstart, bend;
>>+	struct unionfs_sb_info *spd;
>>+
>>+	if ((spd = stopd(sb))) {
>
> Sugg.:
>
> if((spd = stopd(sb)) == NULL)
> 	return;

Better:

  spd = stopd(sb);
  if (!spd)
          return;

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

-- 
VGER BF report: H 0

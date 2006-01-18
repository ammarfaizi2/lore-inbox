Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWARXTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWARXTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWARXTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:19:37 -0500
Received: from mx1.suse.de ([195.135.220.2]:16520 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161047AbWARXTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:19:36 -0500
From: Neil Brown <neilb@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Thu, 19 Jan 2006 10:19:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.52476.290687.858954@cse.unsw.edu.au>
Cc: "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: RE: [PATCH 000 of 5] md: Introduction
In-Reply-To: message from Jan Engelhardt on Wednesday January 18
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com>
	<Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday January 18, jengelh@linux01.gwdg.de wrote:
> 
> >personally, I think this this useful functionality, but my personal
> >preference is that this would be in DM/LVM2 rather than MD.  but given
> >Neil is the MD author/maintainer, I can see why he'd prefer to do it in
> >MD. :)
> 
> Why don't MD and DM merge some bits?
> 

Which bits?
Why?

My current opinion is that you should:

 Use md for raid1, raid5, raid6 - anything with redundancy.
 Use dm for multipath, crypto, linear, LVM, snapshot
 Use either for raid0 (I don't think dm has particular advantages
     for md or md over dm).

These can be mixed together quite effectively:
  You can have dm/lvm over md/raid1 over dm/multipath
with no problems.

If there is functionality missing from any of these recommended
components, then make a noise about it, preferably but not necessarily
with code, and it will quite possibly be fixed.

NeilBrown

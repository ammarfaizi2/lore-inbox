Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUI2Evw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUI2Evw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 00:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268200AbUI2Evv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 00:51:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:36625 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268199AbUI2Evu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 00:51:50 -0400
Date: Wed, 29 Sep 2004 06:50:07 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Ingvar Hagelund <ingvar@linpro.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.27: md RAID1 oops on alpha revisited
Message-ID: <20040929045007.GB721@alpha.home.local>
References: <ujcr7onnup3.fsf@nfsd.linpro.no> <20040928232434.A18395@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928232434.A18395@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 28, 2004 at 11:24:34PM +0400, Ivan Kokshaysky wrote:
> On Tue, Sep 28, 2004 at 01:44:24AM +0200, Ingvar Hagelund wrote:
> > We have a Compaq Alphaserver DS10 466 MHz running Debian Woody with a
> > self compiled 2.4.27 from kernel.org. We have not been able to make it
> > run stable on md RAID1. It always crashes in less than an hour
> > uptime, presumely while stressing the RAID code. Running on single
> > disks, it's rock stable.
> 
> The problem seems to be in qlogic isp1020 driver, not in the RAID code.
> I've seen exactly the same oops report, but that had happened while
> writing to SCSI tape.

I would like to add that I have nearly the same setup with the exception of
an adaptec card and RAID5 instead of RAID1, and it's rock solid. I never had
an oops nor a crash on it and it's my file server. So if it was a RAID1 bug,
it does not affect RAID5 (unlikely). Thus, I too think it's related to the
SCSI driver.

Regards,
Willy


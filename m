Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273949AbRIRVpC>; Tue, 18 Sep 2001 17:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273947AbRIRVow>; Tue, 18 Sep 2001 17:44:52 -0400
Received: from mout0.freenet.de ([194.97.50.131]:32408 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S273945AbRIRVol>;
	Tue, 18 Sep 2001 17:44:41 -0400
Date: Tue, 18 Sep 2001 21:02:28 +0200
To: Tim Sullivan <tsullivan@datawest.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: who writes the "disk_io:" entry in /proc/stat ?
Message-ID: <20010918210228.B629@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Tim Sullivan <tsullivan@datawest.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1000808313.1781.1.camel@prostock.ecom-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.12i
In-Reply-To: <1000808313.1781.1.camel@prostock.ecom-tech.com>; from tsullivan@datawest.net on Tue, Sep 18, 2001 at 04:18:32AM -0600
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 04:18:32AM -0600, Tim Sullivan wrote:
> does anyone know off the top of their head which piece
> of code writes the "disk_io:" entry in /proc/stat ?

drive_stat_acct() in drivers/block/ll_rw_blk.c gathers the data, 
kstat_read_proc() in fs/proc/proc_misc.c implements the output routine.

Format is (device major, disk index):(sum of all io requests,
sum of read io requests, sum of blocks read, sum of write io requests,
sum of blocks written)

Daniel.

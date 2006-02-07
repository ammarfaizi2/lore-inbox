Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWBGJau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWBGJau (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWBGJau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:30:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49823 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750999AbWBGJat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:30:49 -0500
Date: Tue, 7 Feb 2006 09:30:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: alex-lists-linux-kernel@yuriev.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: non-fakeraid controllers
Message-ID: <20060207093048.GC11691@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	alex-lists-linux-kernel@yuriev.com, linux-kernel@vger.kernel.org
References: <20060207015126.GA12236@s2.yuriev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207015126.GA12236@s2.yuriev.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 08:51:26PM -0500, alex-lists-linux-kernel@yuriev.com wrote:
> Hi,
> 
> 	This is not an attempt to start a religious flamewar about what is
> RAID vs. what is softraid vs. what is fakeraid. 
> 
> 	Does anyone has a list/refence/etc on reasonably modern SCSI
> controllers (at least u160) in a non-fakeraid way i.e. the way that would
> allow linux to boot from a RAID protected disk array when one of the drives
> in the array failed even if the root filesystem is located on the same
> array?

LSI 1030/1035 U320 (fusion) controllers have simple raid0/raid1 support

Adaptec and LSI still have some u160 or even u320 controllers in the aacraid/
megaraid series afaik, the present the same interface to the OS for parallel
scsi/sata/sas so it's a bit hard to say for me which is the most recent
parallel scsi one.

The old Mylex controllers supported by drivers/block/DAC960.c support up
to u160, and u320 with an IBM-branded controller which probably isn't sold
separately from IBM Equipment and probably not at all anymore.

The IBM i/pSeries integrated RAID supports up to U320 (drivers/scsi/ipr.c),
but you don't get it without an i/pSeries system.

There's Intel Branded, Adaptec manufactured RAID cards that support U160
SCSI, they're supported by drivers/scsi/gdth.c

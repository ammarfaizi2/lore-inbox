Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTDCTBR 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263472AbTDCTBQ 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:01:16 -0500
Received: from adsl-66-120-100-11.dsl.sndg02.pacbell.net ([66.120.100.11]:14854
	"HELO glacier.arctrix.com") by vger.kernel.org with SMTP
	id S263470AbTDCTBC 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 14:01:02 -0500
Date: Thu, 3 Apr 2003 11:13:12 -0800
From: Neil Schemenauer <nas@python.ca>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RAID 5 performance problems
Message-ID: <20030403191311.GA9406@glacier.arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Vandegrift <ross@willow.seitz.com> wrote:
> Absolutely correct - you should *never* run IDE RAID on a channel that
> has both a master and slave.  When one disk on an IDE channel has an
> error, the whole channel is reset - this makes both disks
> inaccessible,
> and RAID5 now has two failed disks => you data is gone!  *ALWAYS* use
> separate IDE channels.

I think it's okay to use both channels if you use RAID0+1 (also
known as RAID10), just be sure to mirror across channels.  As a
bonus, RAID0+1 is significantly faster than RAID5.

  Neil

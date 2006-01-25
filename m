Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWAYDO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWAYDO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 22:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWAYDO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 22:14:58 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:64645 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1750990AbWAYDO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 22:14:58 -0500
Date: Tue, 24 Jan 2006 19:17:38 -0800
From: thockin@hockin.org
To: Prakash Punnoor <prakash@punnoor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64, 4GB, mttr questions
Message-ID: <20060125031738.GA8656@hockin.org>
References: <200601241433.50625.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601241433.50625.prakash@punnoor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 02:33:46PM +0100, Prakash Punnoor wrote:
> I have a machine with 4GB RAM, an Athlon64 X2 and following mttr entries:
> 
> reg00: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
> reg01: base=0x100000000 (4096MB), size=2048MB: write-back, count=1
> reg02: base=0x80000000 (2048MB), size=2048MB: uncachable, count=1
> 
> First of all, why is there an uncachable region? Is it the upper half of 
> memory? Or is this just a hole and the remaining 2GB are seated at 
> 0x100000000 ?

That's the IO hole between 2 and 4 GB.  Your setup looks fine to me.  It's
perfectly valid to have an uncacheable region overlap a write-back region.

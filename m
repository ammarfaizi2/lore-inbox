Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266794AbTAUIv5>; Tue, 21 Jan 2003 03:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbTAUIv5>; Tue, 21 Jan 2003 03:51:57 -0500
Received: from p508B62F8.dip.t-dialin.net ([80.139.98.248]:4787 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S266794AbTAUIv4>; Tue, 21 Jan 2003 03:51:56 -0500
Date: Tue, 21 Jan 2003 10:00:20 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: Minor header bug? MIPS (32-bit) nlink_t sign
Message-ID: <20030121100020.A15008@linux-mips.org>
References: <20030118033435.GC18282@bjl1.asuk.net> <20030121160959.6e392885.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030121160959.6e392885.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Tue, Jan 21, 2003 at 04:09:59PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 04:09:59PM +1100, Stephen Rothwell wrote:

> > Stephen, I guess you have already figured this out with your recent
> > 32-bit compatibility cleanup?
> 
> I mainly did direct substitutions, but will have a look shortly and see
> what I think.
> 
> I assume we are being compatable with Irix? Ralf?

Dunno where the signed int for nlink_t did come from.  The original idea
was to avoid pointless creativity and choose data types to match IRIX
rsp. the MIPS psABI.  As using a signed type didn't create any visible
problems so far this never got noticed until Jamie Lokier mailed me last
week.  I now changed the definition to unsigned long for the 32-bit
kernel and unsigned int for the 64-bit kernel.

  Ralf

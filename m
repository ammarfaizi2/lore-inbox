Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWGCGca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWGCGca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWGCGca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:32:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58539 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750833AbWGCGc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:32:29 -0400
Date: Mon, 3 Jul 2006 16:32:16 +1000
From: Nathan Scott <nathans@sgi.com>
To: c-otto@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Huge problem with XFS/iCH7R
Message-ID: <20060703163216.B1474487@wobbly.melbourne.sgi.com>
References: <20060702195145.GA4098@localhost.halifax.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060702195145.GA4098@localhost.halifax.rwth-aachen.de>; from c-otto@gmx.de on Sun, Jul 02, 2006 at 09:51:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2006 at 09:51:45PM +0200, Carsten Otto wrote:
> Hi there!
> 
> (System specs below)
> 
> Short summary:
> System (with software raid 5, XFS, four disks connected to AHCI
> controller) crashes very often and loses data.
> 
> My system crashes every few days, at the moment daily. The message shown
> is (the drive changes about every time, I do not see a pattern here):
> ---
> ata4: handling error/timeout
> ata4: port reset, p_is 0 is 0 pis 0 cmd c017 tf 7f ss 0 se 0
> ata4: status=0x50 { DriveReady SeekComplete }
> sdd: Current: sense key=0x0
> 	ASC=0x0 ASCQ=0x0
> Info fid=0x0

FWIW, the above look like hardware/driver problems.

> http://c-otto.de/fehler/

Your first issue there is the XFS dir2 regression discussed recently
here and on xfs@oss.sgi.com - there's a patch available for that and
it's likely to be included in the next -stable release.

> I'd like to know what component causes this problem and how I can solve
> it.

The initial problem (above) and three-of-four of your photos look
unrelated to XFS, but that first image is indicating a (now fixed)
XFS problem - so, looks like you have multiple issues there.

cheers.

-- 
Nathan

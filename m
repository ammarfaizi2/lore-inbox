Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSGYRqt>; Thu, 25 Jul 2002 13:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSGYRqt>; Thu, 25 Jul 2002 13:46:49 -0400
Received: from ns.suse.de ([213.95.15.193]:36105 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316573AbSGYRqr>;
	Thu, 25 Jul 2002 13:46:47 -0400
Date: Thu, 25 Jul 2002 19:50:00 +0200
From: Dave Jones <davej@suse.de>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: MTRR Problems - 2.4.19-rc3
Message-ID: <20020725195000.A8672@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
	rgooch@atnf.csiro.au
References: <200207250303.20809.spstarr@sh0n.net> <20020725150538.U16446@suse.de> <200207251341.24933.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207251341.24933.spstarr@sh0n.net>; from spstarr@sh0n.net on Thu, Jul 25, 2002 at 01:41:24PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 01:41:24PM -0400, Shawn Starr wrote:
 > > > mtrr: no MTRR for e0000000,4000000 found
 > Fair enough, but that doesn't explain the broken MTRR :)

Something in userspace tried to delete an MTRR that didn't exist.
The only time I've seen this happen personally has been with
a dual-head card for which the BIOS set up one MTRR to cover
the video ram used by both heads, and then iirc X did something
silly and tried to remove separate MTRRs for each head on exit.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

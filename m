Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWF3Fgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWF3Fgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 01:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWF3Fgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 01:36:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26310 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751104AbWF3Fgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 01:36:50 -0400
From: Timothy Shimmin <tes@sgi.com>
Organization: SGI
To: Nathan Scott <nathans@sgi.com>
Subject: Re: BUG: held lock freed! with 2.6.17-mm3 and 2.6.17-mm4
Date: Fri, 30 Jun 2006 15:35:40 +1000
User-Agent: KMail/1.8.2
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>, xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
References: <20060629203809.GD20456@charite.de> <20060630081420.A1371683@wobbly.melbourne.sgi.com>
In-Reply-To: <20060630081420.A1371683@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301535.40890.tes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 June 2006 8:14 am, Nathan Scott wrote:
> On Thu, Jun 29, 2006 at 10:38:09PM +0200, Ralf Hildebrandt wrote:
> > 2.6.17-mm3 and mm4 both report a "BUG: held lock freed!" while booting
> > up. Find the two dmesg outputs attached.
>
> Thanks Ralf,
>
> >From the traces, looks like it happens during the unlinked inode list
>
> processing, just after log recovery (I assume you crashed / rebooted
> without unmounting before this boot?).  Tim, do you see any situation
> in recovery where we might have freed an inode while it was locked?

Had a look but I can't see anything apparent at this stage,
let's run our unlink recovery test on the -mm tree next week,
which should expose the bug.

--Tim


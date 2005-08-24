Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVHXN2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVHXN2K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 09:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVHXN2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 09:28:10 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:15769 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750957AbVHXN2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 09:28:10 -0400
Date: Wed, 24 Aug 2005 09:28:08 -0400
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050824132808.GR28551@csclub.uwaterloo.ca>
References: <3AEC1E10243A314391FE9C01CD65429B03CBF7@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B03CBF7@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 06:48:20PM +0530, Mukund JB. wrote:
> My controller itself alone handle FOUR device at a time (u mea these
> should be (tfa, b , c d)
> But how do I represent if I have more than one such controller i.e. it
> is more 4 devices each with more parttions again.

Well the scsi and ide way is that the next controller continues with tfe
f g h, and the next controller has tfi j k and l, etc.  Doesn't mean you
should do it that way, just that that is how it is done for ide and scsi
when multiple controllers are present.  After all normal ide controllers
handle 4 disks maximum (through two ports).  A system with two dual port
ide controllers would have hda ... hdh.

Len Sorensen

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWIYS3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWIYS3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWIYS3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:29:17 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:35748 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750997AbWIYS3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:29:16 -0400
Date: Mon, 25 Sep 2006 11:29:38 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Hammer, Jack" <Jack_Hammer@adaptec.com>, Al Viro <viro@ftp.linux.org.uk>,
       Luben Tuikov <ltuikov@yahoo.com>, dougg@torque.net,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix idiocy in asd_init_lseq_mdp()
Message-ID: <20060925182938.GA4635@us.ibm.com>
References: <4517EBF7.4020508@torque.net> <20060925171634.69667.qmail@web31809.mail.mud.yahoo.com> <20060925173922.GL29920@ftp.linux.org.uk> <1159206202.3463.62.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159206202.3463.62.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
> On Mon, 2006-09-25 at 18:39 +0100, Al Viro wrote:
> > Far more interesting question: where does the hardware expect to see
> > the
> > upper 16 bits of that 32bit value?  Which one it is -
> > LmSEQ_INTEN_SAVE(lseq)
> > ori LmSEQ_INTEN_SAVE(lseq) + 2?
> 
> I don't honestly know.  The change was made as part of a slew of changes
> by Robert Tarte at Adaptec to make the driver run on Big Endian
> platforms.  I've copied Jack Hammer who's now looking after it in the
> hope that he can enlighten us.

This was not Rob. I sent this bad code out in a roll up of support for
non-x86 systems (and bad process for not running sparse on the
patch which passed the buck onto someone else to find).

I think it might have been for an IA64 offset issue someone was seeing. I
cannot find the original mail on the issue in my mail archives.

I will try and track down a IA64 system to see if we can verify this is
really needed. If not we should revert back to the original dword
implementation. 

-andmike
--
Michael Anderson
andmike@us.ibm.com

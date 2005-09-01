Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbVIAU2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbVIAU2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVIAU2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:28:25 -0400
Received: from mail.dvmed.net ([216.237.124.58]:22996 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030373AbVIAU2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:28:24 -0400
Message-ID: <4317645B.4080004@pobox.com>
Date: Thu, 01 Sep 2005 16:28:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Brett Russ <russb@emc.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] libata: Marvell SATA support (PIO mode)
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <4314C604.4030208@pobox.com> <20050901142754.B93BF27137@lns1058.lss.emc.com> <20050901144038.GA25830@infradead.org> <43175B23.8040803@pobox.com> <20050901195832.GA14602@infradead.org> <43175E8F.7080700@pobox.com> <20050901200532.GA14650@infradead.org>
In-Reply-To: <20050901200532.GA14650@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Stop that crap now please.  Adding "scsi.h" includes is _not_ allowed
> for new drivers, period.  There's no exceptions, not even for
> Jeff "I'm part of the calal" Garzik.

There are solid technical reasons (a) why libata drivers include scsi.h, 
and (b) why all libata drivers look similar.  It -impedes- maintenance 
to have one libata driver different from all the others, and this is 
what you are suggesting.

Your suggestion causes nothing but additional work, for zero gain:  as I 
have explained, all the scsi.h includes will go away at the same time. 
Such as sweep would catch all libata drivers, including sata_mv.

Until you're willing to step up and help with 2.4.x maintenance, you're 
just being an impediment for non-technical reasons.  If you want to do 
that, join politics and become a politician.  I have real work to do.

	Jeff



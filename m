Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030546AbWFIV47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbWFIV47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWFIV47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:56:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:41638 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030546AbWFIV46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:56:58 -0400
Message-ID: <4489EEA7.8010704@garzik.org>
Date: Fri, 09 Jun 2006 17:56:55 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com> <4489D36C.3010000@garzik.org> <20060609203523.GE10524@thunk.org> <4489EAFE.6090303@garzik.org> <e6cq1r$foi$1@terminus.zytor.com>
In-Reply-To: <e6cq1r$foi$1@terminus.zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <4489EAFE.6090303@garzik.org>
> By author:    Jeff Garzik <jeff@garzik.org>
> In newsgroup: linux.dev.kernel
>> Theodore Tso wrote:
>>> And I'd also dispute with your "weren't really suited for the original
>>> ext2-style design" comment.  Ext2/3 was always designed to be
>>> extensible from the start, and we've successfully added features quite
>>> successfully for quite a while.

>> Although not the only disk format change, extents are a pretty big one. 
>> Will this be the last major on-disk format change?

> "Last" is a pretty strong word.  Will extents be combined with 64-bit
> block numbers?  That's becoming increasingly urgent.


Right, and that proves my point.  When you start making major changes 
like 32->64 bit block numbers, you should communicate to the user (with 
a big blinky "ext4" sign) that his filesystem metadata will change a 
lot, not a little.  Not to mention that such code will add yet more "if 
(new) .. else .." code.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266883AbUHSRzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUHSRzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266882AbUHSRzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:55:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13755 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266883AbUHSRuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:50:32 -0400
Message-ID: <4124E859.5090303@pobox.com>
Date: Thu, 19 Aug 2004 13:50:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com> <4120E693.8070700@pobox.com> <4124C135.7050200@rtr.ca> <200408191751.19101.bzolnier@elka.pw.edu.pl> <4124E701.5020905@rtr.ca>
In-Reply-To: <4124E701.5020905@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> But there'll need to be some overlap between the old and new,
> and currently the libata driver has no way for smartmontools
> or hdparm to communicate and control drive features like
> the cache/readahead settings, and the various SMART capabilities.


Supporting the ATA Pass-through CDB in libata will enable support for 
all of those things.  I think we all agree that there needs to be _some_ 
way of letting userspace control these attributes via direct ATA command 
submission.

As an aside, although libata _will_ support some sort of user ATA 
command execution method, some of these attributes are (or will be soon) 
available through standard SCSI methods.

For example, MODE SENSE/MODE SELECT on the caching mode page allows one 
to toggle read-ahead and writeback caching.

blktool supports both methods :)

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWGBO3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWGBO3I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 10:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWGBO3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 10:29:08 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:38372 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S932323AbWGBO3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 10:29:06 -0400
Message-ID: <44A7D82A.80909@zen.co.uk>
Date: Sun, 02 Jul 2006 15:28:58 +0100
From: Grant Wilson <grant.wilson@zen.co.uk>
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: Re: 2.6.17-mm5 dislikes raid-1, just like mm4
References: <20060701033524.3c478698.akpm@osdl.org>	 <20060701181455.GA16412@aitel.hist.no>	 <20060701152258.bea091a6.akpm@osdl.org>  <44A7560B.3050000@reub.net> <1151848394.3558.2.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1151848394.3558.2.camel@mulgrave.il.steeleye.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-Rutherford-IP: [82.71.45.175]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Sun, 2006-07-02 at 17:13 +1200, Reuben Farrelly wrote:
>> Just for kicks, after testing those two trees (see previous email) I
>> took my 
>> 2.6.17-mm5 without git-scsi-misc and then patched git-scsi-misc.patch
>> back in, 
>> rebuilt and rebooted and noted that RAID broke again.  Reverted the
>> patch and it 
>> all worked.
>>
>> So I can conclude that definitely and reproduceably that's the
>> one.........
> 
> OK, I have a theory.  I think 
> 
> [SCSI] sd/scsi_lib simplify sd_rw_intr and scsi_io_completion
> 
> Failed to take into account completion of zero length commands (which is
> what a flush is).  Could you try the whole of -mm with this patch?
> 
> Thanks,
> 
> James
> 
[patch snipped]

With the patch applied to 2.6.17-mm5 my RAID-1 is up and running on both
SATA drives with no problems.

Thanks,
Grant

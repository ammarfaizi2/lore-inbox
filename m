Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWFCJbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWFCJbr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 05:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWFCJbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 05:31:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:39599 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932586AbWFCJbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 05:31:47 -0400
From: Andreas Schwab <schwab@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Chris Wright <chrisw@sous-sol.org>,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [stable] [PATCH] sbp2: fix check of return value of	hpsb_allocate_and_register_addrspace
References: <tkrat.f195e45ae32b9c02@s5r6.in-berlin.de>
	<20060603013515.GV18769@moss.sous-sol.org>
	<44814A63.1080707@s5r6.in-berlin.de> <44815283.7080306@tls.msk.ru>
X-Yow: There's a little picture of ED MCMAHON doing BAD THINGS to JOAN RIVERS
 in a $200,000 MALIBU BEACH HOUSE!!
Date: Sat, 03 Jun 2006 11:31:27 +0200
In-Reply-To: <44815283.7080306@tls.msk.ru> (Michael Tokarev's message of "Sat,
	03 Jun 2006 13:12:35 +0400")
Message-ID: <jemzcu7fgw.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev <mjt@tls.msk.ru> writes:

> Stefan Richter wrote:
>> Chris Wright wrote:
>>> * Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
>> ....
>>>> +++ linux-2.6.17-rc5/drivers/ieee1394/sbp2.c    2006-06-03
>>>> 01:54:23.000000000 +0200
>>>> @@ -845,7 +845,7 @@ static struct scsi_id_instance_data *sbp
>>>>             &sbp2_highlevel, ud->ne->host, &sbp2_ops,
>>>>             sizeof(struct sbp2_status_block), sizeof(quadlet_t),
>>>>             0x010000000000ULL, CSR1212_ALL_SPACE_END);
>>>> -    if (!scsi_id->status_fifo_addr) {
>>>> +    if (scsi_id->status_fifo_addr == ~0ULL) {
>
> Umm.  Can this ~0ULL constant be #define'd to something?
> It's way too simple to mis-read it as NULL (or ~NULL whatever).

How about writing it as -1?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

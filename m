Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbUBYNSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbUBYNSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:18:23 -0500
Received: from holomorphy.com ([199.26.172.102]:64520 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261314AbUBYNSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:18:21 -0500
Date: Wed, 25 Feb 2004 05:18:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PRD_ENTRIES is 256
Message-ID: <20040225131817.GK693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
References: <20040225095317.GJ693@holomorphy.com> <200402251411.13945.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402251411.13945.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 of February 2004 10:53, William Lee Irwin III wrote:
>> PRD_ENTRIES is specified to be precisely 256; on platforms where
>> PAGE_SIZE varies from 4KB the calculation in the current expression
>> defining it is inaccurate, which may cause crashes. This patch changes
>> it to the constant literal 256.

On Wed, Feb 25, 2004 at 02:11:13PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Ok, thanks.  However I cannot find 256 entries limit in any ATA document
> and from looking at the code 512 entries shouldn't be a problem (?).
> --bart

The numbers I'm fishing out of things say that the PRD table can't
exceed 64KB in size as it can't cross a 64KB boundary and its length
is specified as a 16-bit byte count, so some other method of sizing
the thing may be in order. I do recall something went wrong at the
time I ran into this. If I turn up where I thought the number 256 came
from I'll cite it.


-- wli

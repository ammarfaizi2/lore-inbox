Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbRGWBrs>; Sun, 22 Jul 2001 21:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268121AbRGWBrj>; Sun, 22 Jul 2001 21:47:39 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:7943 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267633AbRGWBrb>;
	Sun, 22 Jul 2001 21:47:31 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107230147.f6N1lQV200016@saturn.cs.uml.edu>
Subject: Re: RFC: block/loop.c & crypto
To: andrea@suse.de (Andrea Arcangeli)
Date: Sun, 22 Jul 2001 21:47:26 -0400 (EDT)
Cc: hvr@hvrlab.org (Herbert Valerio Riedel), linux-kernel@vger.kernel.org,
        axboe@suse.de
In-Reply-To: <20010723002158.A23517@athlon.random> from "Andrea Arcangeli" at Jul 23, 2001 12:21:58 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andrea Arcangeli writes:
> On Sun, Jul 22, 2001 at 08:53:50PM +0200, Herbert Valerio Riedel wrote:

>> security is not the issue; it's more of practical terms... since
>> 512 byte seems to be the closest practical transfer size (there
>> isn't any smaller blocksize supported with linux) it seems natural
>> to use that one....
>
> to me it sounds more natural to use the 1k blocksize that seems to
> be backwards compatible automatically (without the special case),
> the only disavantage of 1k compared to 512bytes is the decreased
> security, so if the decreased security is not your concern I'd
> suggest to use the 1k fixed granularity for the IV. 1k is also the
> default BLOCK_SIZE I/O granularity used by old linux (which
> incidentally is why it seems backwards compatible automatically).

Being backwards compatible with non-Linus kernels is less important
than choosing a block size that is fit for all block devices.
Disks, partitions, and block-based filesystems are all organized
in power-of-two multiples of 512 bytes.

The smaller size can handle the larger size; the reverse is not true.
We all have to live with the size choice until the end of time.

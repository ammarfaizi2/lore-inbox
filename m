Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVFFFqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVFFFqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 01:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFFFqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 01:46:36 -0400
Received: from smtpout.mac.com ([17.250.248.72]:26561 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261177AbVFFFqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 01:46:34 -0400
In-Reply-To: <1117966262.5027.9.camel@localhost.localdomain>
References: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com> <20050601195922.GA589@openzaurus.ucw.cz> <1117966262.5027.9.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <AF6BB031-9221-4BA3-AFC9-7D167EBE866C@mac.com>
Cc: Pavel Machek <pavel@ucw.cz>, Roy Keene <rkeene@psislidell.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Problem with 2.6 kernel and lots of I/O
Date: Mon, 6 Jun 2005 01:46:18 -0400
To: Erik Slagter <erik@slagter.name>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 5, 2005, at 06:11:02, Erik Slagter wrote:
> On Wed, 2005-06-01 at 21:59 +0200, Pavel Machek wrote:
>
>>>     Start RAID in degraded mode with remote device (nbd1)
>>>     Hot-add local device (nbd0)
>>
>> Stop right here. You may not use nbd over loopback.
>
> Any specific reason (just curious)?

IIRC, because of the way the loopback delivers packets from the
same context as they are sent, it is possible (and quite easy)
to either deadlock or peg the CPU and make everything hang and
be unuseable.  DRBD likewise used to have problems with testing
over the loopback until they added a special configuration
option to be extra careful and yield CPU.

Cheers,
Kyle Moffet


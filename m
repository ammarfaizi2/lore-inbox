Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271184AbTGQLcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271250AbTGQLcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:32:05 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:43537 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S271184AbTGQLcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:32:02 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Date: Thu, 17 Jul 2003 11:46:56 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bf62bg$9cp$1@news.cistron.nl>
References: <20030716184609.GA1913@kroah.com> <20030717122600.A2302@pclin040.win.tue.nl> <bf5uqb$3ei$1@news.cistron.nl> <20030717131955.D2302@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1058442416 9625 62.216.29.200 (17 Jul 2003 11:46:56 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030717131955.D2302@pclin040.win.tue.nl>,
Andries Brouwer  <aebr@win.tue.nl> wrote:
>On Thu, Jul 17, 2003 at 10:46:35AM +0000, Miquel van Smoorenburg wrote:
>
>> The filesystem driver itself must convert from native rdev to linux 32:32.
>
>Look at the mknod utility.
>The user types major,minor.
>The system call uses dev_t.
>This means that user space needs to be able to combine
>major,minor into a dev_t.

Ah, I see. That is a different issue - converting the 32-bit dev_t
from userspace into a 32:32 internal representation.

But, a utility like mknod currently only knows about 8:8 anyway.
It needs to be patched to know about >8:>8 ... why not add
64bit (32:32) dev_t syscalls at the same time ?

I mean, if the 64 bit dev_t is not going to be exposed to userspace,
why bother with it in the kernel ? And if it /is/ going to be
exposed to userspace, why bother with a 32 bit encoding ?

Mike.


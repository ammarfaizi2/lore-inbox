Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUJ0AIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUJ0AIC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUJ0AIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:08:01 -0400
Received: from holomorphy.com ([207.189.100.168]:26345 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261602AbUJ0AHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:07:53 -0400
Date: Tue, 26 Oct 2004 17:07:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Douglas Gilbert <dougg@torque.net>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 2.4] the perils of kunmap_atomic
Message-ID: <20041027000706.GK15367@holomorphy.com>
References: <417EDE4C.20003@pobox.com> <1098834154.7298.29.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098834154.7298.29.camel@desktop.cunninghams>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 09:31, Jeff Garzik wrote:
>> Ignoring the driver-related bugs that are present due to 
>> kunmap_atomic()'s weirdness, there also appears to be a big in the 
>> !CONFIG_HIGHMEM implementation in 2.4.x.
>> (Bart is poking through some of the 2.6.x-related kunmap_atomic slip-ups)
>> Anyway, what do people think about the attached patch to 2.4.x?  I'm 
>> surprised it has gone unnoticed until now.

On Wed, Oct 27, 2004 at 09:42:34AM +1000, Nigel Cunningham wrote:
> On second thoughts, I think it's a bad idea to change the macro - in 2.6
> at least. There are lots of uses of kunmap_atomic, and most of them do
> the right thing. It's only inattentive people like me that need to fix
> their code. :>
> It would be good, though, to have kunmap_atomic warn on invalid
> parameters (want a patch for that?)

The bug Jeff spotted is in 2.4.x only. It's probably worth spitting out
the expected and seen virtual address, and possibly the kmap index.


-- wli

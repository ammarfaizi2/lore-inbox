Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTFXOOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 10:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTFXOOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 10:14:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23216 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262116AbTFXOOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 10:14:45 -0400
Message-ID: <3EF86019.3090608@pobox.com>
Date: Tue, 24 Jun 2003 10:28:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jan-Benedict Glaw <jbglaw@lug-owl.de>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
References: <Pine.SOL.4.30.0306232315480.8078-200000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0306232315480.8078-200000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> TCQ shouldn't be enabled on hdc, you have two drives on second ide
> channel and current TCQ driver design allows only one drive per channel,
> so proper fix is to not enable TCQ :-).


IMO the best rule is "enable TCQ if and only if 100% of the channel 
supports TCQ".

So, two drives on the same channel can do TCQ, if and only if they both 
support TCQ.  That's a big benefit of bus release, after all, 
simultaneously servicing multiple drives.  The device-select and service 
interrupt semantics are annoying but doable.

	Jeff




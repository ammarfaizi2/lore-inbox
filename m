Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUFJQjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUFJQjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUFJQjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:39:12 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:60311 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S261951AbUFJQjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:39:11 -0400
Date: Thu, 10 Jun 2004 10:41:35 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jeff Garzik <jgarzik@pobox.com>, Ed Tomlinson <edt@aei.ca>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040610164135.GA2230@bounceswoosh.org>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	"Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
	Jeff Garzik <jgarzik@pobox.com>, Ed Tomlinson <edt@aei.ca>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20040610061141.GD13836@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10 at  8:11, Jens Axboe wrote:
>On Thu, Jun 10 2004, Bartlomiej Zolnierkiewicz wrote:
>> 
>> /me just thinks loudly
>> 
>> 'linear range' FLUSH CACHE seems so easy to implement that I always wondered
>> why FLUSH CACHE command doesn't make any use of LBA address and number
>> of sectors.
>
>Indeed, that would be very helpful as well.

Neat idea... so you send us a LBA and a block count, and we return
good status if that region is flushed.

Each command can specify a 32MiB region, assuming a device with
512-byte LBAs.

Propose an exact implementation and an opcode...

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUFKQdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUFKQdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUFKQ0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:26:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56771 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264228AbUFKQYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:24:14 -0400
Message-ID: <40C9DCA1.5020509@pobox.com>
Date: Fri, 11 Jun 2004 12:24:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and
 later)
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com> <40C8A241.50608@pobox.com> <20040611075515.GR13836@suse.de>
In-Reply-To: <20040611075515.GR13836@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jun 10 2004, Jeff Garzik wrote:
> 
>>Oh, also:
>>
>>We'll need to write up precisely _why_ this is used, and give some 
>>examples of usage, for people reading the proposal (mostly T13-ish 
>>people) who have not been following the lkml barrier discussion closely.
> 
> 
> Proposal looks fine, but please lets not forget that flush cache range
> is really a band-aid because we don't have a proper ordered write in the
> first place. Personally, I'd much rather see that implemented than flush
> cache range. It would be way more effective.


Certainly agreed, and that was the gist of the reply just sent to Eric: 
  moving forward, implementing barriers should be done with new "NCQ" 
commands and FUA, or something along those lines.

New drives will continue to come out that aren't in the NCQ class for a 
while yet, though.

	Jeff



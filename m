Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbUKCTFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUKCTFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbUKCTE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:04:59 -0500
Received: from 200.80-202-166.nextgentel.com ([80.202.166.200]:60875 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261816AbUKCTD0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:03:26 -0500
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, DervishD <lkml@dervishd.net>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net>
	<200411031147.14179.gene.heskett@verizon.net>
	<20041103174459.GA23015@DervishD>
	<200411031353.39468.gene.heskett@verizon.net>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Wed, 03 Nov 2004 20:03:01 +0100
In-Reply-To: <200411031353.39468.gene.heskett@verizon.net> (Gene Heskett's
 message of "Wed, 3 Nov 2004 13:53:39 -0500")
Message-ID: <yw1x7jp2hi1m.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> On Wednesday 03 November 2004 12:44, DervishD wrote:
>>    Hi Gene :)
>>
>> * Gene Heskett <gene.heskett@verizon.net> dixit:
>>> >    Or write a little program that just 'wait()'s for the
>>> > specified PID's. That is perfectly portable IMHO. But I must
>>> > admit that the preferred way should be killing the parent.
>>> > 'init' will reap the children after that.
>>>
>>> But what if there is no parent, since the system has already
>>> disposed of it?
>>
>>    Then the children are reparented to 'init' and 'init' gets rid
>> of them. That's the way UNIX behaves.
>
> Unforch, I've *never* had it work that way.  Any dead process I've 
> ever had while running linux has only been disposable by a reboot.

That's because its parent was still sitting around refusing to wait()
for them.

-- 
Måns Rullgård
mru@inprovide.com

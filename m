Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVEIUk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVEIUk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 16:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVEIUjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 16:39:33 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:58046 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261516AbVEIUjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 16:39:12 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: Bug: 2.6.11.8 msdos.c
To: Bill Davidsen <davidsen@tmr.com>, linux-os@analogic.com,
       James Dingwall <james.dingwall@cramer.com>,
       linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl,
       Chris Wright <chrisw@osdl.org>
Reply-To: 7eggert@gmx.de
Date: Mon, 09 May 2005 22:38:50 +0200
References: <42kyq-2oO-35@gated-at.bofh.it> <41bQz-2lJ-15@gated-at.bofh.it> <42kyq-2oO-33@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DVF1f-0003QU-G9@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:
> Richard B. Johnson wrote:
>> On Fri, 6 May 2005, Bill Davidsen wrote:

>>> I looked at the rest of msdos.c and it wasn't blindingly clear what the
>>> original intent was. A partition type of zero is unusual, but it's not
>>> illegal, is it? (as in violates some standard)

>> Can't the problem be fixed by just using Linux fdisk to put in the
>> correct ID?  Unlike MS-DOS fdisk, the Linux fdisk can modify things
>> without destroying everything else on the drive.
> 
> Yes, that works. My question was why a zero was considered a bad value
> instead of "reserved." Not that I disagree, I just don't see the reason.

The values in the other fields are asumed to be ignored if the ID is 0.
Therefore, some people store their company name there, which, interpreted
as a partition address, results e.g. in overlapping partitions.

If there is a automounter, this bogus partition will be mounted, and if
it happens to look like having a valid filesystem, this will result in
data corruption or crashes.
-- 
Fun things to slip into your budget
Does that line item say 'Personal Massage System' Oops, it's supposed to be
'Message'. Go ahead and sign the authorization, Boss; I'll correct it later.
(Iike Hell I will)

